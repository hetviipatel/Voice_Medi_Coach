import 'package:flutter/material.dart';

class SummaryChartScreen extends StatelessWidget {
  const SummaryChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    // Accent colors (keep for highlights)
    const accentBlue = Color(0xFF42A5F5);
    const accentTeal = Color(0xFF26C6DA);
    const accentPink = Color(0xFFEC407A);
    const borderGlow = Color(0xFF42A5F5);

    // Theme-aware backgrounds and text
    final scaffoldBg = colorScheme.background;
    final cardBg = colorScheme.surface;
    final cardAltBg = isDark ? const Color(0xFF2D313A) : Colors.white;
    final textPrimary = colorScheme.onSurface;
    final textSecondary = colorScheme.onSurfaceVariant;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        title: Text(
          'Your Daily Progress',
          style: textTheme.headlineSmall?.copyWith(color: accentBlue, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: accentBlue),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Health Summary Card
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Health Summary', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: textPrimary)),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Medication Adherence', style: textTheme.bodyMedium?.copyWith(color: textSecondary)),
                            Text('95%', style: textTheme.bodyMedium?.copyWith(color: textPrimary, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Appointments', style: textTheme.bodyMedium?.copyWith(color: textSecondary)),
                            Text('2 Upcoming', style: textTheme.bodyMedium?.copyWith(color: textPrimary, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Last Check-up', style: textTheme.bodyMedium?.copyWith(color: textSecondary)),
                            Text('15 days ago', style: textTheme.bodyMedium?.copyWith(color: textPrimary, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: accentBlue,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text('Good', style: textTheme.labelLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            // Progress Chart
            Text(
              'Progress Summary Chart',
              style: textTheme.titleLarge?.copyWith(color: accentBlue, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Attractive fake chart
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: borderGlow.withOpacity(0.25),
                    blurRadius: 16,
                    spreadRadius: 2,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                margin: EdgeInsets.zero,
                color: cardAltBg,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Fake chart bars
                      Positioned(
                        left: 40,
                        bottom: 40,
                        child: _FakeBar(height: 80, color: accentBlue),
                      ),
                      Positioned(
                        left: 80,
                        bottom: 40,
                        child: _FakeBar(height: 120, color: accentTeal),
                      ),
                      Positioned(
                        left: 120,
                        bottom: 40,
                        child: _FakeBar(height: 60, color: accentPink),
                      ),
                      Positioned(
                        left: 160,
                        bottom: 40,
                        child: _FakeBar(height: 100, color: accentBlue.withOpacity(0.7)),
                      ),
                      Positioned(
                        left: 200,
                        bottom: 40,
                        child: _FakeBar(height: 140, color: accentTeal.withOpacity(0.7)),
                      ),
                      // Chart label
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            'Weekly Progress',
                            style: textTheme.bodyLarge?.copyWith(color: textSecondary, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Recent Reports Section
            Text(
              'Recent Reports',
              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: textPrimary),
            ),
            const SizedBox(height: 16),
            _ReportCard(
              icon: Icons.favorite,
              iconBg: accentPink.withOpacity(0.15),
              title: 'Blood Pressure Report',
              date: 'March 15, 2024',
              status: 'Normal',
              statusColor: accentPink.withOpacity(0.18),
              statusTextColor: accentPink,
            ),
            const SizedBox(height: 12),
            _ReportCard(
              icon: Icons.medication,
              iconBg: accentBlue.withOpacity(0.15),
              title: 'Medication Review',
              date: 'March 10, 2024',
              status: 'Completed',
              statusColor: accentBlue.withOpacity(0.18),
              statusTextColor: accentBlue,
            ),
            const SizedBox(height: 12),
            _ReportCard(
              icon: Icons.shield,
              iconBg: accentTeal.withOpacity(0.15),
              title: 'General Check-up',
              date: 'March 5, 2024',
              status: 'Good',
              statusColor: accentTeal.withOpacity(0.18),
              statusTextColor: accentTeal,
            ),
            const SizedBox(height: 30),
            // Personalized Advice
            Text(
              'Personalized Advice',
              style: textTheme.titleLarge?.copyWith(color: accentBlue, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              color: cardAltBg,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Great job staying on track with 75% of your medications today! To improve further, consider setting reminders for your evening doses. You\'ve consistently taken your morning meds, which is a strong foundation.',
                      style: textTheme.bodyMedium?.copyWith(color: textSecondary),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '[Future improvement: This advice will be dynamic based on actual medication adherence data and mood tracking.]',
                      style: textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic, color: textSecondary.withOpacity(0.7)),
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

class _FakeBar extends StatelessWidget {
  final double height;
  final Color color;
  const _FakeBar({required this.height, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            color.withOpacity(0.9),
            color.withOpacity(0.5),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String date;
  final String status;
  final Color? statusColor;
  final Color? statusTextColor;
  const _ReportCard({required this.icon, required this.iconBg, required this.title, required this.date, required this.status, this.statusColor, this.statusTextColor});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF23272F) : colorScheme.surface;
    final titleColor = isDark ? Colors.white : colorScheme.onSurface;
    final dateColor = isDark ? const Color(0xFFB0B6C1) : colorScheme.onSurfaceVariant;
    return Card(
      color: cardColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: titleColor)),
                  const SizedBox(height: 4),
                  Text(date, style: textTheme.bodyMedium?.copyWith(color: dateColor)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(status, style: textTheme.bodyMedium?.copyWith(color: statusTextColor, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
} 