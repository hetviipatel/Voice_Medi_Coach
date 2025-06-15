import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _selectedLanguage = 'English';
  bool _notificationsEnabled = true;
  bool _showEmergencyInfo = false;
  
  // Mock user data - replace with actual user data from your auth system
  final String _userName = 'John Doe';
  final String _userEmail = 'john.doe@example.com';
  
  // Emergency contacts
  final List<Map<String, String>> _emergencyContacts = [
    {'name': 'Dr. Sarah Smith', 'relation': 'Primary Doctor', 'phone': '+1 234-567-8901'},
    {'name': 'Jane Doe', 'relation': 'Family Member', 'phone': '+1 234-567-8902'},
  ];

  // Health conditions
  final List<String> _healthConditions = [
    'Type 2 Diabetes',
    'Hypertension',
    'Asthma'
  ];

  // Medication preferences
  final Map<String, bool> _medicationPreferences = {
    'Take with food': true,
    'Take before bed': false,
    'Take on empty stomach': false,
    'Avoid dairy products': true,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: textTheme.headlineSmall?.copyWith(color: colorScheme.onSurface),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.onSurfaceVariant),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header with gradient background
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.primary,
                    colorScheme.primaryContainer,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: colorScheme.onPrimary, width: 2),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: colorScheme.surface,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _userName,
                    style: textTheme.headlineMedium?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  Text(
                    _userEmail,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onPrimary.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Emergency Information Section
                  _buildSectionHeader(
                    'Emergency Information',
                    Icons.emergency_outlined,
                    colorScheme.error,
                  ),
                  const SizedBox(height: 12),
                  _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Emergency Contacts',
                              style: textTheme.titleMedium,
                            ),
                            IconButton(
                              icon: Icon(
                                _showEmergencyInfo ? Icons.expand_less : Icons.expand_more,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              onPressed: () {
                                setState(() {
                                  _showEmergencyInfo = !_showEmergencyInfo;
                                });
                              },
                            ),
                          ],
                        ),
                        if (_showEmergencyInfo) ...[
                          const SizedBox(height: 12),
                          ..._emergencyContacts.map((contact) => Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: colorScheme.errorContainer,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(Icons.phone, color: colorScheme.onError, size: 20),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        contact['name']!,
                                        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        '${contact['relation']!} • ${contact['phone']!}',
                                        style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )).toList(),
                          const SizedBox(height: 8),
                          _buildAddButton('Add Emergency Contact', context),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Health Conditions Section
                  _buildSectionHeader(
                    'Health Conditions',
                    Icons.health_and_safety_outlined,
                    colorScheme.secondary,
                  ),
                  const SizedBox(height: 12),
                  _buildCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._healthConditions.map((condition) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(Icons.medical_services_outlined, color: colorScheme.onSecondary, size: 20),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                condition,
                                style: textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        )).toList(),
                        const SizedBox(height: 8),
                        _buildAddButton('Add Health Condition', context),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Medication Preferences Section
                  _buildSectionHeader(
                    'Medication Preferences',
                    Icons.medication_outlined,
                    colorScheme.tertiary,
                  ),
                  const SizedBox(height: 12),
                  _buildCard(
                    child: Column(
                      children: _medicationPreferences.entries.map((preference) => SwitchListTile(
                        title: Text(
                          preference.key,
                          style: textTheme.bodyMedium,
                        ),
                        value: preference.value,
                        onChanged: (bool value) {
                          setState(() {
                            _medicationPreferences[preference.key] = value;
                          });
                        },
                        activeColor: colorScheme.tertiary,
                        secondary: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.settings_outlined, color: colorScheme.onTertiary, size: 20),
                        ),
                      )).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Language Preference
                  _buildSectionHeader(
                    'Language Preference',
                    Icons.translate_outlined,
                    colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  _buildCard(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: colorScheme.outline),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedLanguage,
                          isExpanded: true,
                          items: ['English', 'Hindi', 'Gujarati']
                              .map((language) => DropdownMenuItem(
                                    value: language,
                                    child: Text(language, style: textTheme.bodyMedium), // Ensure text theme
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedLanguage = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Notification Toggle
                  _buildSectionHeader(
                    'Notifications',
                    Icons.notifications_outlined,
                    colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  _buildCard(
                    child: SwitchListTile(
                      title: Text(
                        'Enable Notifications',
                        style: textTheme.bodyMedium,
                      ),
                      value: _notificationsEnabled,
                      onChanged: (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                      },
                      activeColor: colorScheme.primary,
                      secondary: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.notifications_outlined, color: colorScheme.onPrimary, size: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/auth_gateway');
                      },
                      icon: Icon(Icons.logout, color: colorScheme.onError),
                      label: Text(
                        'Logout',
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.onError,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: textTheme.titleMedium,
        ),
      ],
    );
  }

  Widget _buildCard({required Widget child}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }

  Widget _buildAddButton(String text, BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return TextButton.icon(
      onPressed: () {
        // TODO: Implement add functionality
      },
      icon: Icon(Icons.add_circle_outline, size: 18, color: colorScheme.primary),
      label: Text(text, style: textTheme.labelLarge?.copyWith(color: colorScheme.primary)),
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
      ),
    );
  }

  Future<void> _showDeleteAccountConfirmationDialog(BuildContext context) async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete your account?', style: textTheme.bodyMedium),
                Text('This action cannot be undone.', style: textTheme.bodySmall?.copyWith(color: colorScheme.error)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: textTheme.labelLarge?.copyWith(color: colorScheme.onSurfaceVariant)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete', style: textTheme.labelLarge?.copyWith(color: colorScheme.error)),
              onPressed: () {
                // TODO: Implement actual account deletion logic
                Navigator.of(context).pop(); // Close dialog
                Navigator.pushReplacementNamed(context, '/auth_gateway'); // Navigate to login/signup
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Account deleted.', style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface))),
                );
              },
            ),
          ],
        );
      },
    );
  }
} 