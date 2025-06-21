import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeModeNotifier;
  const SettingsScreen({super.key, required this.themeModeNotifier});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Voice Settings
  double _sttVolume = 0.8;
  double _ttsVolume = 0.8;
  double _sttSpeed = 1.0;
  double _ttsSpeed = 1.0;

  // Alert Settings
  bool _medicationReminders = true;
  bool _missedDoseAlerts = true;
  bool _sideEffectNotifications = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: textTheme.headlineSmall?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.primary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Settings Section
            _buildSectionHeader('Theme Settings', Icons.brightness_6, colorScheme.tertiary, context),
            const SizedBox(height: 12),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              margin: EdgeInsets.zero,
              color: colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    RadioListTile<ThemeMode>(
                      title: Text('System Default', style: textTheme.bodyMedium),
                      value: ThemeMode.system,
                      groupValue: widget.themeModeNotifier.value,
                      onChanged: (ThemeMode? newValue) {
                        if (newValue != null) {
                          widget.themeModeNotifier.value = newValue;
                        }
                      },
                      activeColor: colorScheme.primary,
                    ),
                    RadioListTile<ThemeMode>(
                      title: Text('Light Mode', style: textTheme.bodyMedium),
                      value: ThemeMode.light,
                      groupValue: widget.themeModeNotifier.value,
                      onChanged: (ThemeMode? newValue) {
                        if (newValue != null) {
                          widget.themeModeNotifier.value = newValue;
                        }
                      },
                      activeColor: colorScheme.primary,
                    ),
                    RadioListTile<ThemeMode>(
                      title: Text('Dark Mode', style: textTheme.bodyMedium),
                      value: ThemeMode.dark,
                      groupValue: widget.themeModeNotifier.value,
                      onChanged: (ThemeMode? newValue) {
                        if (newValue != null) {
                          widget.themeModeNotifier.value = newValue;
                        }
                      },
                      activeColor: colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Voice Settings Section
            _buildSectionHeader('Voice Settings', Icons.record_voice_over, colorScheme.primary, context),
            const SizedBox(height: 12),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              margin: EdgeInsets.zero,
              color: colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildSettingSlider(
                      'STT Volume', _sttVolume, (value) => setState(() => _sttVolume = value),
                      context,
                      min: 0.0, max: 1.0, divisions: 10, label: _sttVolume.toStringAsFixed(1),
                    ),
                    _buildSettingSlider(
                      'TTS Volume', _ttsVolume, (value) => setState(() => _ttsVolume = value),
                      context,
                      min: 0.0, max: 1.0, divisions: 10, label: _ttsVolume.toStringAsFixed(1),
                    ),
                    _buildSettingSlider(
                      'STT Speed', _sttSpeed, (value) => setState(() => _sttSpeed = value),
                      context,
                      min: 0.5, max: 2.0, divisions: 15, label: _sttSpeed.toStringAsFixed(1),
                    ),
                    _buildSettingSlider(
                      'TTS Speed', _ttsSpeed, (value) => setState(() => _ttsSpeed = value),
                      context,
                      min: 0.5, max: 2.0, divisions: 15, label: _ttsSpeed.toStringAsFixed(1),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Alert Settings Section
            _buildSectionHeader('Alert Settings', Icons.notifications_active, colorScheme.secondary, context),
            const SizedBox(height: 12),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              margin: EdgeInsets.zero,
              color: colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildSettingToggle(
                      'Medication Reminders', _medicationReminders,
                      (value) => setState(() => _medicationReminders = value),
                      context,
                    ),
                    _buildSettingToggle(
                      'Missed Dose Alerts', _missedDoseAlerts,
                      (value) => setState(() => _missedDoseAlerts = value),
                      context,
                    ),
                    _buildSettingToggle(
                      'Side Effect Notifications', _sideEffectNotifications,
                      (value) => setState(() => _sideEffectNotifications = value),
                      context,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Export Logs Section
            _buildSectionHeader('Data Management', Icons.upload_file, colorScheme.tertiary, context),
            const SizedBox(height: 12),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              margin: EdgeInsets.zero,
              color: colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Implement export logs as PDF
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Exporting logs as PDF...', style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface))),
                          );
                        },
                        icon: Icon(Icons.picture_as_pdf, color: colorScheme.onPrimary),
                        label: Text(
                          'Export Logs as PDF',
                          style: textTheme.labelLarge?.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.tertiary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Delete Account Section
            _buildSectionHeader('Account Actions', Icons.delete_forever, colorScheme.error, context),
            const SizedBox(height: 12),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              margin: EdgeInsets.zero,
              color: colorScheme.surface,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement delete account logic
                    _showDeleteAccountConfirmationDialog(context);
                  },
                  icon: Icon(Icons.warning_amber, color: colorScheme.onError),
                  label: Text(
                    'Delete Account',
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.onError,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.error,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color, BuildContext context) {
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

  Widget _buildSettingSlider(String title, double value, ValueChanged<double> onChanged, BuildContext context, {double min = 0.0, double max = 1.0, int divisions = 10, String? label}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.bodyMedium,
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            label: label,
            onChanged: onChanged,
            activeColor: colorScheme.primary,
            inactiveColor: colorScheme.primaryContainer,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingToggle(String title, bool value, ValueChanged<bool> onChanged, BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return SwitchListTile(
      title: Text(
        title,
        style: textTheme.bodyMedium,
      ),
      value: value,
      onChanged: onChanged,
      activeColor: colorScheme.secondary,
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