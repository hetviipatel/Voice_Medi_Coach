import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_medication_coach/providers/theme_provider.dart';
import 'package:voice_medication_coach/providers/language_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: textTheme.headlineSmall),
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Theme Mode
          ListTile(
            leading: Icon(Icons.brightness_6, color: colorScheme.primary),
            title: Text('Theme', style: textTheme.titleMedium),
            trailing: DropdownButton<ThemeMode>(
              value: themeProvider.themeMode,
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Default'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark'),
                ),
              ],
              onChanged: (mode) {
                if (mode != null) themeProvider.setThemeMode(mode);
              },
            ),
          ),
          const Divider(),

          // Language
          ListTile(
            leading: Icon(Icons.language, color: colorScheme.primary),
            title: Text('Language', style: textTheme.titleMedium),
            trailing: DropdownButton<String>(
              value: languageProvider.language,
              items: [
                DropdownMenuItem(value: 'English', child: Text('English')),
                DropdownMenuItem(value: 'Hindi', child: Text('Hindi')),
                DropdownMenuItem(value: 'Gujarati', child: Text('Gujarati')),
                // Add more languages as needed
              ],
              onChanged: (lang) {
                if (lang != null) languageProvider.setLanguage(lang);
              },
            ),
          ),
          const Divider(),

          // Notifications
          SwitchListTile(
            secondary: Icon(Icons.notifications, color: colorScheme.primary),
            title: Text('Enable Notifications', style: textTheme.titleMedium),
            value: themeProvider.notificationsEnabled,
            onChanged: (val) => themeProvider.setNotifications(val),
          ),
          const Divider(),

          // About
          ListTile(
            leading: Icon(Icons.info, color: colorScheme.primary),
            title: Text('About', style: textTheme.titleMedium),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'MediVoice Admin Panel',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2024 MediVoice',
              );
            },
          ),
          const Divider(),

          // Logout
          ListTile(
            leading: Icon(Icons.logout, color: colorScheme.error),
            title: Text('Logout', style: textTheme.titleMedium?.copyWith(color: colorScheme.error)),
            onTap: () {
              // Implement logout logic
            },
          ),
        ],
      ),
    );
  }
} 