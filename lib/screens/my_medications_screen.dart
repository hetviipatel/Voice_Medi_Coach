import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voice_medication_coach/screens/add_edit_medication_screen.dart';
import 'package:voice_medication_coach/screens/rewards_screen.dart';

class MyMedicationsScreen extends StatefulWidget {
  const MyMedicationsScreen({super.key});

  @override
  State<MyMedicationsScreen> createState() => _MyMedicationsScreenState();
}

class _MyMedicationsScreenState extends State<MyMedicationsScreen> {
  // Dummy data for medications
  List<Map<String, dynamic>> _medications = [
    {'name': 'Amoxicillin', 'dosage': '250mg', 'status': 'Taken'},
    {'name': 'Ibuprofen', 'dosage': '400mg', 'status': 'Upcoming'},
    {'name': 'Metformin', 'dosage': '500mg', 'status': 'Missed'},
  ];

  int _streak = 0; // Simulated streak for demo
  bool _showCelebration = false;

  void _markAsTaken(int index) {
    setState(() {
      _medications[index]['status'] = 'Taken';
      if (_medications.every((m) => m['status'] == 'Taken')) {
        _showCelebration = true;
        _streak++;
      }
    });
  }

  void _closeCelebration() {
    setState(() {
      _showCelebration = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final brightness = theme.brightness;
    final int takenCount = _medications.where((m) => m['status'] == 'Taken').length;
    final int totalCount = _medications.length;
    final double progress = totalCount == 0 ? 0 : takenCount / totalCount;
    final bool allTaken = totalCount > 0 && takenCount == totalCount;
    // For demo: streak if all taken for 3+ days (simulate)
    final bool hasStreak = allTaken && totalCount >= 3;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.primary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'My Medications',
          style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.emoji_events, color: Colors.amber),
            tooltip: 'View Rewards',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const RewardsScreen()));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              if (totalCount > 0) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 12,
                            backgroundColor: brightness == Brightness.dark ? Colors.white12 : Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(progress == 1.0 ? Colors.green : colorScheme.primary),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text('${(progress * 100).round()}%', style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: progress == 1.0 ? Colors.green : colorScheme.primary)),
                      if (_streak > 0)
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: brightness == Brightness.dark ? colorScheme.background : Colors.amber[700],
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [BoxShadow(color: Colors.amber.withOpacity(0.3), blurRadius: 8, offset: Offset(0, 4))],
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.local_fire_department, color: Colors.white, size: 18),
                              const SizedBox(width: 4),
                              Text('${_streak}-day Streak!', style: textTheme.labelLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: Icon(Icons.emoji_events, color: Colors.white, size: 20),
                                tooltip: 'View Rewards',
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const RewardsScreen()));
                                },
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                if (allTaken)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10, bottom: 4),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: brightness == Brightness.dark ? colorScheme.background : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('🎉 All medications taken! Great job!', style: textTheme.titleMedium?.copyWith(color: Colors.green, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: Icon(Icons.emoji_events, color: Colors.amber, size: 26),
                          tooltip: 'View Rewards',
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const RewardsScreen()));
                          },
                        ),
                      ],
                    ),
                  ),
              ],
              Expanded(
                child: _medications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.medication_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Your medications will appear here.',
                              style: textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Add your first medication to get started!',
                              style: textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
                  ),
                ],
              ),
            )
          : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              itemCount: _medications.length,
              itemBuilder: (context, index) {
                final medication = _medications[index];
                          final status = medication['status'];
                          Color cardColor = brightness == Brightness.dark ? const Color(0xFF232A36).withOpacity(0.95) : Colors.white;
                          Color shadowColor = brightness == Brightness.dark ? colorScheme.primary.withOpacity(0.18) : colorScheme.primary.withOpacity(0.08);
                          Color statusColor = status == 'Taken'
                              ? Colors.green.shade400
                              : status == 'Missed'
                                  ? Colors.red.shade400
                                  : Colors.orange.shade400;
                          IconData statusIcon = status == 'Taken'
                              ? Icons.check_circle
                              : status == 'Missed'
                                  ? Icons.cancel
                                  : Icons.timelapse;
                          return Column(
                      children: [
                              _MedicationCard(
                                name: medication['name']!,
                                dosage: medication['dosage']!,
                                status: status,
                                cardColor: cardColor,
                                shadowColor: shadowColor,
                                statusColor: statusColor,
                                statusIcon: statusIcon,
                                onEdit: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEditMedicationScreen(
                                      medication: medication,
                                    ),
                                  ),
                                );
                                if (result != null) {
                                  setState(() {
                                    _medications[index] = result;
                                  });
                                }
                              },
                                onDelete: () {
                                setState(() {
                                  _medications.removeAt(index);
                                });
                              },
                                onMarkAsTaken: status != 'Taken' ? () => _markAsTaken(index) : null,
                              ),
                              const SizedBox(height: 18),
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
          if (_showCelebration)
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeCelebration,
                child: Container(
                  color: Colors.black.withOpacity(0.7),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Simple confetti/celebration preview
                        Text('🎉', style: TextStyle(fontSize: 80)),
                        const SizedBox(height: 24),
                        Text('Congratulations!', style: textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Text("You've taken all your medications today!", style: textTheme.titleLarge?.copyWith(color: Colors.white70)),
                        if (_streak > 0 && _streak % 10 == 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Column(
                              children: [
                                Text('🏆', style: TextStyle(fontSize: 60)),
                                Text('Amazing! $_streak-day streak!', style: textTheme.titleLarge?.copyWith(color: Colors.amber, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        const SizedBox(height: 30),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              _closeCelebration();
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const RewardsScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                              elevation: 4,
                            ),
                            child: const Text('View My Rewards'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('(Tap anywhere to close)', style: textTheme.bodySmall?.copyWith(color: Colors.white54)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MedicationCard extends StatefulWidget {
  final String name;
  final String dosage;
  final String status;
  final Color cardColor;
  final Color shadowColor;
  final Color statusColor;
  final IconData statusIcon;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onMarkAsTaken;
  const _MedicationCard({
    required this.name,
    required this.dosage,
    required this.status,
    required this.cardColor,
    required this.shadowColor,
    required this.statusColor,
    required this.statusIcon,
    required this.onEdit,
    required this.onDelete,
    this.onMarkAsTaken,
    super.key,
  });
  @override
  State<_MedicationCard> createState() => _MedicationCardState();
}

class _MedicationCardState extends State<_MedicationCard> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(_isHovering ? 1.025 : 1.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: widget.shadowColor,
              blurRadius: _isHovering ? 24 : 12,
              offset: const Offset(0, 8),
            ),
          ],
          borderRadius: BorderRadius.circular(28),
        ),
        child: Card(
          color: widget.cardColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(widget.statusIcon, color: widget.statusColor, size: 28),
                    const SizedBox(width: 10),
                    Text(
                      widget.name,
                      style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Dosage: ${widget.dosage}',
                  style: textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 8),
                Text(
                  'Status: ${widget.status}',
                  style: textTheme.bodyLarge?.copyWith(
                    color: widget.statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (widget.onMarkAsTaken != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton.icon(
                          onPressed: widget.onMarkAsTaken,
                          icon: Icon(Icons.check, color: Colors.white, size: 18),
                          label: Text('Mark as Taken', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            elevation: 0,
                          ),
                        ),
                      ),
                    AnimatedScale(
                      scale: _isHovering ? 1.2 : 1.0,
                      duration: const Duration(milliseconds: 180),
                      child: IconButton(
                        icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
                        onPressed: widget.onEdit,
                        tooltip: 'Edit',
                      ),
                    ),
                    AnimatedScale(
                      scale: _isHovering ? 1.2 : 1.0,
                      duration: const Duration(milliseconds: 180),
                      child: IconButton(
                        icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
                        onPressed: widget.onDelete,
                        tooltip: 'Delete',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlowingFAB extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;
  const _GlowingFAB({required this.onPressed, required this.label, super.key});
  @override
  State<_GlowingFAB> createState() => _GlowingFABState();
}

class _GlowingFABState extends State<_GlowingFAB> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          boxShadow: _isHovering
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.35),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
          borderRadius: BorderRadius.circular(24),
        ),
        child: FloatingActionButton.extended(
          onPressed: widget.onPressed,
        label: Text(
            widget.label,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          icon: const Icon(Icons.add, color: Colors.white),
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }
}