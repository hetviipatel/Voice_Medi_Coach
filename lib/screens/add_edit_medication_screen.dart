import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddEditMedicationScreen extends StatefulWidget {
  final Map<String, dynamic>? medication;

  const AddEditMedicationScreen({super.key, this.medication});

  @override
  State<AddEditMedicationScreen> createState() => _AddEditMedicationScreenState();
}

class _AddEditMedicationScreenState extends State<AddEditMedicationScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _dosageController;
  late TextEditingController _frequencyController;
  String _frequencyType = 'daily';
  int _timesPerDay = 1;
  DateTime? _startDate;
  DateTime? _endDate;
  List<TimeOfDay> _reminderTimes = [const TimeOfDay(hour: 8, minute: 0)];
  String _status = 'Upcoming';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.medication?['name']);
    _dosageController = TextEditingController(text: widget.medication?['dosage']);
    _frequencyController = TextEditingController(text: widget.medication?['frequency']);
    _frequencyType = widget.medication?['frequencyType'] ?? 'daily';
    _timesPerDay = widget.medication?['timesPerDay'] ?? 1;
    _startDate = widget.medication?['startDate'] != null 
        ? DateTime.parse(widget.medication!['startDate'])
        : DateTime.now();
    _endDate = widget.medication?['endDate'] != null 
        ? DateTime.parse(widget.medication!['endDate'])
        : null;
    _reminderTimes = widget.medication?['reminderTimes'] != null
        ? (widget.medication!['reminderTimes'] as List)
            .map((time) => TimeOfDay(
                hour: int.parse(time.split(':')[0]),
                minute: int.parse(time.split(':')[1])))
            .toList()
        : [const TimeOfDay(hour: 8, minute: 0)];
    _status = widget.medication?['status'] ?? 'Upcoming';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _frequencyController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now().add(const Duration(days: 30))),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _reminderTimes[index],
    );
    if (picked != null) {
      setState(() {
        _reminderTimes[index] = picked;
      });
    }
  }

  void _addReminderTime() {
    setState(() {
      _reminderTimes.add(const TimeOfDay(hour: 8, minute: 0));
    });
  }

  void _removeReminderTime(int index) {
    setState(() {
      _reminderTimes.removeAt(index);
    });
  }

  void _saveMedication() {
    if (_formKey.currentState!.validate()) {
      final result = {
        'name': _nameController.text,
        'dosage': _dosageController.text,
        'frequencyType': _frequencyType,
        'timesPerDay': _timesPerDay,
        'startDate': _startDate?.toIso8601String(),
        'endDate': _endDate?.toIso8601String(),
        'reminderTimes': _reminderTimes.map((time) => '${time.hour}:${time.minute}').toList(),
        'status': _status,
      };
      print('Add/Edit Medication: Saving medication: $result');
      Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.medication == null ? 'Add New Medication' : 'Edit Medication',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Medicine Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Medicine Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.local_pharmacy),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter medicine name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Dosage
              TextFormField(
                controller: _dosageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Dosage',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.science),
                  suffixText: 'mg',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter dosage';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Frequency
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _frequencyType,
                      decoration: InputDecoration(
                        labelText: 'Frequency',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.repeat),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'daily', child: Text('Daily')),
                        DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                        DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _frequencyType = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (_frequencyType == 'daily')
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _timesPerDay,
                        decoration: InputDecoration(
                          labelText: 'Times per day',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: List.generate(4, (index) => index + 1)
                            .map((value) => DropdownMenuItem(
                                  value: value,
                                  child: Text('$value'),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _timesPerDay = value!;
                            if (_reminderTimes.length < value) {
                              _reminderTimes.addAll(
                                List.generate(
                                  value - _reminderTimes.length,
                                  (index) => const TimeOfDay(hour: 8, minute: 0),
                                ),
                              );
                            } else if (_reminderTimes.length > value) {
                              _reminderTimes.removeRange(value, _reminderTimes.length);
                            }
                          });
                        },
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),

              // Start Date
              ListTile(
                title: Text(
                  'Start Date',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                subtitle: Text(
                  _startDate != null
                      ? DateFormat('MMM dd, yyyy').format(_startDate!)
                      : 'Select start date',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, true),
              ),
              const SizedBox(height: 10),

              // End Date
              ListTile(
                title: Text(
                  'End Date (Optional)',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                subtitle: Text(
                  _endDate != null
                      ? DateFormat('MMM dd, yyyy').format(_endDate!)
                      : 'Select end date',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, false),
              ),
              const SizedBox(height: 20),

              // Reminder Times
              Text(
                'Reminder Times',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _reminderTimes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'Reminder ${index + 1}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    subtitle: Text(
                      _reminderTimes[index].format(context),
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.access_time),
                          onPressed: () => _selectTime(context, index),
                        ),
                        if (_reminderTimes.length > 1)
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => _removeReminderTime(index),
                          ),
                      ],
                    ),
                  );
                },
              ),
              if (_reminderTimes.length < 4)
                TextButton.icon(
                  onPressed: _addReminderTime,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Reminder Time'),
                ),
              const SizedBox(height: 20),

              // Status
              DropdownButtonFormField<String>(
                value: _status,
                decoration: InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.info_outline),
                ),
                items: <String>['Taken', 'Missed', 'Upcoming']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _status = newValue!;
                  });
                },
              ),
              const SizedBox(height: 30),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveMedication,
                  icon: const Icon(Icons.save),
                  label: Text(
                    widget.medication == null ? 'Add Medication' : 'Save Changes',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 