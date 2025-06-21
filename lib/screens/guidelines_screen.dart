import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class GuidelinesScreen extends StatefulWidget {
  const GuidelinesScreen({super.key});

  @override
  State<GuidelinesScreen> createState() => _GuidelinesScreenState();
}

class _GuidelinesScreenState extends State<GuidelinesScreen> {
  // Family emergency contacts (editable)
  List<Map<String, String>> _familyContacts = [
    {'name': 'Mom', 'phone': '+1 234-567-8901'},
    {'name': 'Dad', 'phone': '+1 234-567-8902'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // MediWell palette
    final bgColor = isDark ? const Color(0xFF181F2A) : const Color(0xFFF7F9FB);
    final cardColor = isDark ? const Color(0xFF232B3A) : Colors.white;
    final primary = const Color(0xFF42A5F5);
    final secondary = const Color(0xFF90CAF9);
    final error = isDark ? Colors.red.shade300 : Colors.red.shade400;
    final onCard = isDark ? Colors.white : Colors.black87;
    final onBg = isDark ? Colors.white : Colors.black;
    final tagBg = isDark ? primary.withOpacity(0.15) : primary.withOpacity(0.08);
    final tagText = primary;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'Guidelines',
          style: textTheme.headlineSmall?.copyWith(color: primary, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Existing Guidelines Content ---
            Text(
              'Basic Healthcare Tips',
              style: textTheme.titleLarge?.copyWith(color: primary, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildGuidelineCard(cardColor, onCard, primary, textTheme, 'Stay Hydrated', 'Drink at least 8 glasses of water daily to maintain good health and help your body absorb medications.'),
            _buildGuidelineCard(cardColor, onCard, primary, textTheme, 'Balanced Diet', 'Eat a variety of fruits, vegetables, lean proteins, and whole grains. Avoid processed foods and excessive sugar.'),
            _buildGuidelineCard(cardColor, onCard, primary, textTheme, 'Regular Exercise', 'Aim for at least 30 minutes of moderate exercise most days of the week to boost your immune system and mood.'),
            _buildGuidelineCard(cardColor, onCard, primary, textTheme, 'Adequate Sleep', 'Ensure 7-9 hours of quality sleep per night. Good sleep is crucial for physical and mental recovery.'),
            const SizedBox(height: 30),
            Text(
              'Emergency Numbers',
              style: textTheme.titleLarge?.copyWith(color: error, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildEmergencyContactCard(cardColor, error, onCard, textTheme, 'Emergency Services', 'Dial 911 (or your local emergency number)', '911'),
            _buildEmergencyContactCard(cardColor, error, onCard, textTheme, 'Poison Control', '1-800-222-1222', '18002221222'),
            _buildEmergencyContactCard(cardColor, error, onCard, textTheme, 'Hospital', '+1 234-567-8903', '12345678903'),
            _buildEmergencyContactCard(cardColor, error, onCard, textTheme, 'Ambulance', '108', '108'),
            _buildEmergencyContactCard(cardColor, error, onCard, textTheme, 'My Primary Contact', '+1 234-567-8904', '12345678904'),
            const SizedBox(height: 30),
            Text(
              'My Family Emergency Contacts',
              style: textTheme.titleLarge?.copyWith(color: error, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ..._familyContacts.asMap().entries.map((entry) => _buildFamilyContactCard(entry.key, entry.value, cardColor, error, onCard, textTheme)),
            _buildAddFamilyContactButton(cardColor, error, onCard, textTheme),
            const SizedBox(height: 30),
            Text(
              'General Guidelines',
              style: textTheme.titleLarge?.copyWith(color: primary, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildGuidelineCard(cardColor, onCard, primary, textTheme, 'Follow Medication Instructions', 'Always take your medications exactly as prescribed by your doctor. Do not skip doses or alter dosages without medical advice.'),
            _buildGuidelineCard(cardColor, onCard, primary, textTheme, 'Report Side Effects', 'If you experience any unusual symptoms or side effects, contact your doctor or pharmacist immediately.'),
            _buildGuidelineCard(cardColor, onCard, primary, textTheme, 'Keep Medications Safe', 'Store medications in a cool, dry place, away from direct sunlight and out of reach of children and pets.'),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelineCard(Color cardColor, Color onCard, Color primary, TextTheme textTheme, String title, String description) {
    return Card(
      color: cardColor,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: primary),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: textTheme.bodyMedium?.copyWith(color: onCard.withOpacity(0.85)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyContactCard(Color cardColor, Color error, Color onCard, TextTheme textTheme, String name, String numberDisplay, String numberDial) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor = isDark
        ? error.withOpacity(0.12)
        : const Color(0xFFFFEBEE); // Soft red-tinted background for light mode
    return Card(
      color: bgColor,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Dialing $numberDisplay')),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(Icons.phone, color: error, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: error),
                    ),
                    Text(
                      numberDisplay,
                      style: textTheme.bodyLarge?.copyWith(color: error),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: error, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFamilyContactCard(int index, Map<String, String> contact, Color cardColor, Color error, Color onCard, TextTheme textTheme) {
    return Card(
      color: cardColor,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(Icons.family_restroom, color: error),
        title: Text(contact['name'] ?? '', style: textTheme.titleMedium?.copyWith(color: onCard, fontWeight: FontWeight.bold)),
        subtitle: Text(contact['phone'] ?? '', style: textTheme.bodyMedium?.copyWith(color: onCard)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: error),
              onPressed: () => _showEditFamilyContactDialog(index),
              tooltip: 'Edit',
            ),
            IconButton(
              icon: Icon(Icons.delete, color: error),
              onPressed: () => setState(() => _familyContacts.removeAt(index)),
              tooltip: 'Delete',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddFamilyContactButton(Color cardColor, Color error, Color onCard, TextTheme textTheme) {
    return Center(
      child: OutlinedButton.icon(
        icon: Icon(Icons.add, color: error),
        label: Text('Add Family Contact', style: textTheme.labelLarge?.copyWith(color: error, fontWeight: FontWeight.bold)),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: error, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        ),
        onPressed: _showAddFamilyContactDialog,
      ),
    );
  }

  void _showAddFamilyContactDialog() {
    String name = '';
    String phone = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Family Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) => name = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
              onChanged: (value) => phone = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (name.trim().isNotEmpty && phone.trim().isNotEmpty) {
                setState(() {
                  _familyContacts.add({'name': name.trim(), 'phone': phone.trim()});
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditFamilyContactDialog(int index) {
    String name = _familyContacts[index]['name'] ?? '';
    String phone = _familyContacts[index]['phone'] ?? '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Family Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              controller: TextEditingController(text: name),
              onChanged: (value) => name = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
              controller: TextEditingController(text: phone),
              onChanged: (value) => phone = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (name.trim().isNotEmpty && phone.trim().isNotEmpty) {
                setState(() {
                  _familyContacts[index] = {'name': name.trim(), 'phone': phone.trim()};
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
} 