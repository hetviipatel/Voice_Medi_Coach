import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  // Dummy data for reminders
  final List<Map<String, dynamic>> _reminders = [
    {'id': 1, 'time': TimeOfDay(hour: 8, minute: 0), 'medication': 'Amoxicillin', 'isOn': true},
    {'id': 2, 'time': TimeOfDay(hour: 12, minute: 30), 'medication': 'Ibuprofen', 'isOn': false},
    {'id': 3, 'time': TimeOfDay(hour: 18, minute: 0), 'medication': 'Metformin', 'isOn': true},
  ];

  void _toggleReminder(int index, bool value) {
    setState(() {
      _reminders[index]['isOn'] = value;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Reminders',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.blue.shade800,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blueAccent),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _reminders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No reminders set yet.',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Add a medication to set reminders!',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _reminders.length,
              itemBuilder: (context, index) {
                final reminder = _reminders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reminder['medication']!,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                reminder['time'].format(context),
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blueAccent),
                          onPressed: () => _editReminderTime(context, index),
                        ),
                        Switch(
                          value: reminder['isOn'],
                          onChanged: (value) => _toggleReminder(index, value),
                          activeColor: Colors.blueAccent,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
} 