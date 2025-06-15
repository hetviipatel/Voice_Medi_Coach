import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  int? _selectedMoodIndex;
  final List<String> _moodEmojis = ['😊', '😁', '😐', '😞', '😡'];
  final List<String> _moodLabels = [
    'Happy', 'Excited', 'Neutral', 'Sad', 'Angry'
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Mood Tracker',
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How are you feeling today?',
              style: textTheme.headlineSmall,
            ),
            const SizedBox(height: 30),
            Center(
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: List.generate(_moodEmojis.length, (index) {
                  final bool isSelected = _selectedMoodIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedMoodIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? colorScheme.primaryContainer : colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected
                            ? [BoxShadow(color: colorScheme.primary.withOpacity(0.2), blurRadius: 10, spreadRadius: 2)]
                            : [],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _moodEmojis[index],
                            style: const TextStyle(fontSize: 40),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _moodLabels[index],
                            style: textTheme.bodyMedium?.copyWith(
                              color: isSelected ? colorScheme.onPrimaryContainer : colorScheme.onSurface,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _selectedMoodIndex == null
                    ? null
                    : () {
                        // TODO: Implement mood logging logic (e.g., save to database)
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Mood logged: ${_moodLabels[_selectedMoodIndex!]}',
                              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary),
                            ),
                            backgroundColor: colorScheme.primary,
                          ),
                        );
                        // Optionally navigate back or reset state
                        // Navigator.pop(context);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                ),
                child: Text(
                  'Log Mood',
                  style: textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 