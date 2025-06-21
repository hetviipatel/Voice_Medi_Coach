import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  int? _selectedMoodIndex;
  bool _showCelebration = false;
  String? _loggedMood;
  final List<String> _moodEmojis = ['😊', '😁', '😐', '😞', '😡'];
  final List<String> _moodLabels = [
    'Happy', 'Excited', 'Neutral', 'Sad', 'Angry'
  ];

  void _logMood() {
    setState(() {
      _showCelebration = true;
      _loggedMood = _moodLabels[_selectedMoodIndex!];
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showCelebration = false;
        _selectedMoodIndex = null;
      });
    });
  }

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
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 16,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                    side: BorderSide(color: colorScheme.primary, width: 2),
                  ),
                  shadowColor: colorScheme.primary.withOpacity(0.18),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How are you feeling today?',
                          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: Wrap(
                            spacing: 28,
                            runSpacing: 28,
                            children: List.generate(_moodEmojis.length, (index) {
                              final bool isSelected = _selectedMoodIndex == index;
                              return _MoodOption(
                                emoji: _moodEmojis[index],
                                label: _moodLabels[index],
                                isSelected: isSelected,
                                onTap: () {
                                  setState(() {
                                    _selectedMoodIndex = index;
                                  });
                                },
                                colorScheme: colorScheme,
                                textTheme: textTheme,
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _selectedMoodIndex == null ? null : _logMood,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Text('Log Mood', style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // TODO: Implement mood history navigation
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Mood history coming soon!')),
                              );
                            },
                            icon: Icon(Icons.history, color: colorScheme.primary),
                            label: Text('View Mood History', style: textTheme.labelLarge?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold)),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: colorScheme.primary, width: 2),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
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
          if (_showCelebration)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('✅', style: TextStyle(fontSize: 80)),
                      const SizedBox(height: 24),
                      Text('Mood Logged!', style: textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      if (_loggedMood != null)
                        Text('You logged: $_loggedMood', style: textTheme.titleLarge?.copyWith(color: Colors.white70)),
                      const SizedBox(height: 20),
                      Text('"Every feeling is valid. Keep tracking!"', style: textTheme.bodyLarge?.copyWith(color: Colors.white70, fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MoodOption extends StatefulWidget {
  final String emoji;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  const _MoodOption({required this.emoji, required this.label, required this.isSelected, required this.onTap, required this.colorScheme, required this.textTheme});
  @override
  State<_MoodOption> createState() => _MoodOptionState();
}

class _MoodOptionState extends State<_MoodOption> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()..scale(_isHovering || widget.isSelected ? 1.08 : 1.0),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? widget.colorScheme.primary.withOpacity(0.18)
                : widget.colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: widget.isSelected ? widget.colorScheme.primary : widget.colorScheme.outlineVariant,
              width: widget.isSelected ? 2.5 : 1.2,
            ),
            boxShadow: (widget.isSelected || _isHovering)
                ? [
                    BoxShadow(
                      color: widget.colorScheme.primary.withOpacity(0.18),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.emoji,
                style: const TextStyle(fontSize: 40),
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: widget.textTheme.bodyMedium?.copyWith(
                  color: widget.isSelected ? widget.colorScheme.primary : widget.colorScheme.onSurface,
                  fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 