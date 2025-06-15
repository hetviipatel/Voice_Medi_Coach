import 'package:flutter/material.dart';

class SummaryChartScreen extends StatelessWidget {
  const SummaryChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Daily Progress',
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
              'Progress Summary Chart',
              style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
            ),
            const SizedBox(height: 20),
            // Placeholder for the chart
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                '[Placeholder for a detailed progress chart]',
                style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Personalized Advice',
              style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
            ),
            const SizedBox(height: 12),
            Card(
              color: colorScheme.surfaceContainerHighest,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: colorScheme.outlineVariant),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Great job staying on track with 75% of your medications today! To improve further, consider setting reminders for your evening doses. You\'ve consistently taken your morning meds, which is a strong foundation.',
                      style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '[Future improvement: This advice will be dynamic based on actual medication adherence data and mood tracking.]',
                      style: textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic, color: colorScheme.onSurfaceVariant.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 