import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  // Dummy data for reminders
  final List<Map<String, dynamic>> _reminders = [
    {'id': 1, 'time': TimeOfDay(hour: 8, minute: 0), 'medication': 'Amoxicillin', 'isOn': true, 'description': ''},
    {'id': 2, 'time': TimeOfDay(hour: 12, minute: 30), 'medication': 'Ibuprofen', 'isOn': false, 'description': ''},
    {'id': 3, 'time': TimeOfDay(hour: 18, minute: 0), 'medication': 'Metformin', 'isOn': true, 'description': ''},
  ];

  void _toggleReminder(int index, bool value) async {
    if (!value) {
      // If turning off, ask for reason
      final reason = await _showReasonDialog();
      setState(() {
        _reminders[index]['isOn'] = value;
        if (reason != null && reason.trim().isNotEmpty) {
          _reminders[index]['description'] = reason.trim();
        }
      });
    } else {
      setState(() {
        _reminders[index]['isOn'] = value;
      });
    }
  }

  Future<String?> _showReasonDialog() async {
    String reason = '';
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Why are you turning off this reminder?'),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter reason (optional)'),
          onChanged: (val) => reason = val,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, reason),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editDescription(int index) async {
    String desc = _reminders[index]['description'] ?? '';
    final controller = TextEditingController(text: desc);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Description'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Add a note or description...'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (result != null) {
      setState(() {
        _reminders[index]['description'] = result.trim();
      });
    }
  }

  Future<void> _editReminderTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _reminders[index]['time'],
    );
    if (picked != null) {
      setState(() {
        _reminders[index]['time'] = picked;
      });
    }
  }

  void _addReminder() async {
    final result = await _showEditReminderDialog();
    if (result != null) {
      setState(() {
        _reminders.add(result);
      });
    }
  }

  void _editReminder(int index) async {
    final result = await _showEditReminderDialog(existing: _reminders[index], allowDelete: true);
    if (result == null) return;
    if (result is Map<String, dynamic>) {
      setState(() {
        _reminders[index] = result;
      });
    } else if (result == 'delete') {
      setState(() {
        _reminders.removeAt(index);
      });
    }
  }

  Future<dynamic> _showEditReminderDialog({Map<String, dynamic>? existing, bool allowDelete = false}) async {
    String name = existing?['medication'] ?? '';
    String desc = existing?['description'] ?? '';
    TimeOfDay time = existing?['time'] ?? TimeOfDay.now();
    bool isStarred = existing?['isStarred'] ?? false;
    final nameController = TextEditingController(text: name);
    final descController = TextEditingController(text: desc);
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(existing == null ? 'Add Reminder' : 'Edit Reminder'),
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 340, minWidth: 300),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Medication Name'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: 'Description (optional)'),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 20),
                      const SizedBox(width: 8),
                      Text('Time: ${time.format(context)}'),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () async {
                          final picked = await showTimePicker(context: context, initialTime: time);
                          if (picked != null) setState(() => time = picked);
                        },
                        child: const Text('Pick'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isStarred,
                        onChanged: (v) => setState(() => isStarred = v ?? false),
                      ),
                      const Text('Mark as important'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          actions: [
            if (allowDelete)
              TextButton(
                onPressed: () => Navigator.pop(context, 'delete'),
                child: const Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(80, 40),
              ),
              onPressed: nameController.text.trim().isEmpty
                  ? null
                  : () {
                      Navigator.pop(context, {
                        'id': existing?['id'] ?? DateTime.now().millisecondsSinceEpoch,
                        'medication': nameController.text.trim(),
                        'description': descController.text.trim(),
                        'time': time,
                        'isOn': existing?['isOn'] ?? true,
                        'isStarred': isStarred,
                      });
                    },
              child: Text(existing == null ? 'Add' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;
    // Colors for dark/light theme
    final bgGradient = isDark
        ? [const Color(0xFF181F2A), const Color(0xFF232B3A), const Color(0xFF2B3350)]
        : [const Color(0xFFe3f0ff), const Color(0xFFb6d0f7), const Color(0xFFc7bfff)];
    final cardColor = isDark ? const Color(0xFF232B3A).withOpacity(0.98) : Colors.white.withOpacity(0.85);
    final cardBorder = isDark ? const Color(0xFF3A4250) : Colors.black12;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white70 : Colors.black54;
    final editEnabled = isDark ? const Color(0xFF42A5F5) : const Color(0xFF42A5F5);
    final editDisabled = isDark ? Colors.grey[400] : Colors.grey;
    final editBgEnabled = isDark ? const Color(0xFF232B3A) : const Color(0xFFe3f0ff);
    final editBgDisabled = isDark ? const Color(0xFF232B3A) : Colors.grey[200];
    final switchActive = const Color(0xFF42A5F5);
    final switchInactiveThumb = isDark ? Colors.grey[600] : Colors.grey[400];
    final switchInactiveTrack = isDark ? Colors.grey[800] : Colors.grey[300];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: switchActive),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Reminders',
          style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: switchActive),
        ),
        centerTitle: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: bgGradient,
          ),
        ),
        child: SafeArea(
          child: _reminders.isEmpty
              ? _buildEmptyState(context, textTheme, textColor, subTextColor)
              : ListView.builder(
                  padding: const EdgeInsets.all(20.0),
                  itemCount: _reminders.length,
                  itemBuilder: (context, index) {
                    final reminder = _reminders[index];
                    final isEnabled = reminder['isOn'] as bool;
                    final isStarred = reminder['isStarred'] ?? false;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: cardBorder, width: 1.2),
                          boxShadow: [
                            BoxShadow(
                              color: isDark ? Colors.black.withOpacity(0.25) : Colors.black.withOpacity(0.08),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 22),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _editReminder(index),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              reminder['medication']!,
                                              style: textTheme.titleLarge?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: textColor,
                                                fontSize: 22,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ),
                                          if (isStarred)
                                            const Icon(Icons.star, color: Colors.amber, size: 22),
                                        ],
                                      ),
                                      if ((reminder['description'] ?? '').isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4.0, bottom: 2.0),
                                          child: Text(
                                            reminder['description'],
                                            style: textTheme.bodyMedium?.copyWith(color: subTextColor, fontStyle: FontStyle.italic),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      const SizedBox(height: 10),
                                      Container(
                                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [Color(0xFF42A5F5), Color(0xFF7B61FF)],
                                          ),
                                          borderRadius: BorderRadius.circular(18),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF42A5F5).withOpacity(0.10),
                                              blurRadius: 6,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          reminder['time'].format(context),
                                          style: textTheme.bodyLarge?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Modern circular edit button
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: isEnabled ? () => _editReminderTime(context, index) : null,
                                  child: Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isEnabled ? editBgEnabled : editBgDisabled,
                                      border: Border.all(color: isEnabled ? editEnabled : editDisabled!, width: 2),
                                    ),
                                    child: Icon(Icons.edit, color: isEnabled ? editEnabled : editDisabled, size: 24),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Modern, visible switch
                              Switch(
                                value: isEnabled,
                                onChanged: (value) => _toggleReminder(index, value),
                                activeColor: switchActive,
                                inactiveThumbColor: switchInactiveThumb,
                                inactiveTrackColor: switchInactiveTrack,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: _reminders.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: _addReminder,
              backgroundColor: switchActive,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Add Reminder', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              elevation: 8,
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context, TextTheme textTheme, Color textColor, Color subTextColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('⏰', style: TextStyle(fontSize: 80)),
          const SizedBox(height: 24),
          Text(
            'No reminders yet!',
            style: textTheme.headlineSmall?.copyWith(color: textColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Tap below to add your first medication reminder.',
            style: textTheme.bodyLarge?.copyWith(color: subTextColor),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: _addReminder,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text('Add Reminder', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF42A5F5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
              elevation: 8,
            ),
          ),
        ],
      ),
    );
  }
} 