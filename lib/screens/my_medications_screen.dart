import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voice_medication_coach/screens/add_edit_medication_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Medications',
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
      body: _medications.isEmpty
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
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Add your first medication to get started!',
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
              itemCount: _medications.length,
              itemBuilder: (context, index) {
                final medication = _medications[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medication['name']!,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Dosage: ${medication['dosage']}',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Status: ${medication['status']}',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: medication['status'] == 'Taken'
                                ? Colors.green.shade700
                                : medication['status'] == 'Missed'
                                    ? Colors.red.shade700
                                    : Colors.orange.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blueAccent),
                              onPressed: () async {
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
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () {
                                setState(() {
                                  _medications.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          print('My Medications: Before adding, list size: ${_medications.length}');
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditMedicationScreen(),
            ),
          );
          if (result != null) {
            setState(() {
              _medications.add(result);
            });
            print('My Medications: After adding, list size: ${_medications.length}');
          }
        },
        label: Text(
          'Add New Medication',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}