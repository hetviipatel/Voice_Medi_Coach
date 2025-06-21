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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.medication == null ? 'Add New Medication' : 'Edit Medication',
          style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF42A5F5)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
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
                          borderRadius: BorderRadius.circular(16),
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
                          borderRadius: BorderRadius.circular(16),
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
                                borderRadius: BorderRadius.circular(16),
                        ),
                        prefixIcon: const Icon(Icons.repeat),
                      ),
                            items: ['daily', 'weekly', 'monthly']
                                .map((type) => DropdownMenuItem(
                                      value: type,
                                      child: Text(type[0].toUpperCase() + type.substring(1)),
                                    ))
                                .toList(),
                      onChanged: (value) {
                        setState(() {
                          _frequencyType = value!;
                        });
                      },
                    ),
                  ),
                        const SizedBox(width: 16),
                    Expanded(
                          child: TextFormField(
                            controller: _frequencyController,
                            keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                              labelText: 'Times/Day',
                          border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              prefixIcon: const Icon(Icons.timelapse),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter times per day';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Enter a valid number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Start and End Dates
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context, true),
                            child: AbsorbPointer(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Start Date',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  prefixIcon: const Icon(Icons.calendar_today),
                                ),
                                controller: TextEditingController(
                                  text: _startDate != null ? DateFormat('yyyy-MM-dd').format(_startDate!) : '',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context, false),
                            child: AbsorbPointer(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'End Date',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  prefixIcon: const Icon(Icons.calendar_today),
                                ),
                                controller: TextEditingController(
                                  text: _endDate != null ? DateFormat('yyyy-MM-dd').format(_endDate!) : '',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
              ),
              const SizedBox(height: 20),

              // Reminder Times
              Text(
                'Reminder Times',
                      style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.primary),
              ),
              const SizedBox(height: 10),
                    ..._reminderTimes.asMap().entries.map((entry) {
                      int index = entry.key;
                      TimeOfDay time = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _selectTime(context, index),
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Time',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      prefixIcon: const Icon(Icons.access_time),
                                    ),
                                    controller: TextEditingController(
                                      text: time.format(context),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                        if (_reminderTimes.length > 1)
                          IconButton(
                                icon: Icon(Icons.remove_circle, color: colorScheme.error),
                            onPressed: () => _removeReminderTime(index),
                          ),
                      ],
                    ),
                  );
                    }).toList(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                  onPressed: _addReminderTime,
                        icon: Icon(Icons.add, color: colorScheme.primary),
                        label: Text('Add Time', style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary)),
                      ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                  onPressed: _saveMedication,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text(
                          widget.medication == null ? 'Add Medication' : 'Save Changes',
                          style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
} 