import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    // For demo, simulate a 7-day streak
    final int streak = 7;
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('My Rewards', style: textTheme.headlineSmall?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text('🔥 $streak-day Streak!', style: textTheme.headlineMedium?.copyWith(color: Colors.orange, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Text('Badges Earned:', style: textTheme.titleLarge?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold)),
            const SizedBox(height: 18),
            Wrap(
              spacing: 18,
              runSpacing: 18,
              children: [
                _RewardBadge(icon: '🥉', label: '3 Days', achieved: streak >= 3),
                _RewardBadge(icon: '🥈', label: '7 Days', achieved: streak >= 7),
                _RewardBadge(icon: '🥇', label: '10 Days', achieved: streak >= 10),
                _RewardBadge(icon: '🏅', label: '20 Days', achieved: streak >= 20),
              ],
            ),
            const SizedBox(height: 40),
            Text('"Small steps every day lead to big results!"',
                style: textTheme.titleMedium?.copyWith(color: colorScheme.primary, fontStyle: FontStyle.italic), textAlign: TextAlign.center),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _RewardBadge extends StatelessWidget {
  final String icon;
  final String label;
  final bool achieved;
  const _RewardBadge({required this.icon, required this.label, required this.achieved});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Opacity(
      opacity: achieved ? 1.0 : 0.3,
      child: Column(
        children: [
          Text(icon, style: TextStyle(fontSize: 40)),
          const SizedBox(height: 6),
          Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary)),
        ],
      ),
    );
  }
} 