import 'package:flutter/material.dart';

class GuidelinesScreen extends StatelessWidget {
  const GuidelinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Guidelines',
          style: textTheme.headlineSmall?.copyWith(color: colorScheme.onSurface),
        ),
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Healthcare Tips',
              style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
            ),
            const SizedBox(height: 12),
            _buildGuidelineCard(
              context,
              'Stay Hydrated',
              'Drink at least 8 glasses of water daily to maintain good health and help your body absorb medications.',
            ),
            _buildGuidelineCard(
              context,
              'Balanced Diet',
              'Eat a variety of fruits, vegetables, lean proteins, and whole grains. Avoid processed foods and excessive sugar.',
            ),
            _buildGuidelineCard(
              context,
              'Regular Exercise',
              'Aim for at least 30 minutes of moderate exercise most days of the week to boost your immune system and mood.',
            ),
            _buildGuidelineCard(
              context,
              'Adequate Sleep',
              'Ensure 7-9 hours of quality sleep per night. Good sleep is crucial for physical and mental recovery.',
            ),
            const SizedBox(height: 30),

            Text(
              'Emergency Numbers',
              style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
            ),
            const SizedBox(height: 12),
            _buildEmergencyContactCard(
              context,
              'Emergency Services',
              'Dial 911 (or your local emergency number)',
              '911',
            ),
            _buildEmergencyContactCard(
              context,
              'Poison Control',
              '1-800-222-1222',
              '18002221222',
            ),
            _buildEmergencyContactCard(
              context,
              'Your Doctor\'s Office',
              '(123) 456-7890',
              '1234567890',
            ),
            const SizedBox(height: 30),

            Text(
              'General Guidelines',
              style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
            ),
            const SizedBox(height: 12),
            _buildGuidelineCard(
              context,
              'Follow Medication Instructions',
              'Always take your medications exactly as prescribed by your doctor. Do not skip doses or alter dosages without medical advice.',
            ),
            _buildGuidelineCard(
              context,
              'Report Side Effects',
              'If you experience any unusual symptoms or side effects, contact your doctor or pharmacist immediately.',
            ),
            _buildGuidelineCard(
              context,
              'Keep Medications Safe',
              'Store medications in a cool, dry place, away from direct sunlight and out of reach of children and pets.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelineCard(BuildContext context, String title, String description) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Card(
      color: colorScheme.surfaceContainerHighest,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyContactCard(BuildContext context, String name, String numberDisplay, String numberDial) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Card(
      color: colorScheme.errorContainer.withOpacity(0.2), // Use a subtle error color for emergency
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.error), // Highlight with error color
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // TODO: Implement actual phone call functionality
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Dialing $numberDisplay')),
          );
          // Example: launchUrl(Uri.parse('tel:$numberDial'));
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.phone, color: colorScheme.error, size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: colorScheme.onErrorContainer),
                    ),
                    Text(
                      numberDisplay,
                      style: textTheme.bodyLarge?.copyWith(color: colorScheme.onErrorContainer),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: colorScheme.error, size: 20),
            ],
          ),
        ),
      ),
    );
  }
} 