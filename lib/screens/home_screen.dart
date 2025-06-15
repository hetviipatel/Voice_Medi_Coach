import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TODO: Replace with actual user name, perhaps fetched from an authentication service
  final String _userName = 'Hetvi'; 

  // Mock data for Daily Health Summary - replace with actual data
  final int _medsTakenToday = 2;
  final int _totalMedsToday = 3;
  final String _lastMood = 'Happy'; // e.g., fetched from Mood Tracker
  final String _nextMedicationTime = '8:00 AM';
  final String _nextMedicationName = 'Amoxicillin';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: textTheme.headlineSmall?.copyWith(color: colorScheme.onSurface),
        ),
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorScheme.primary, colorScheme.primaryContainer],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: colorScheme.surface,
                    child: Icon(Icons.person, size: 30, color: colorScheme.primary),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'John Doe', // Replace with dynamic user name
                    style: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
                  ),
                  Text(
                    'john.doe@example.com', // Replace with dynamic user email
                    style: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.notifications, 'Notifications', () {
              Navigator.pop(context); // Close the drawer
              // TODO: Navigate to notifications
            }, context),
            _buildDrawerItem(Icons.alarm, 'Reminders', () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(context, '/reminders');
            }, context),
            _buildDrawerItem(Icons.assistant_direction, 'Guidelines', () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(context, '/guidelines');
            }, context),
            _buildDrawerItem(Icons.person, 'Profile', () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(context, '/profile');
            }, context),
            _buildDrawerItem(Icons.settings, 'Settings', () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(context, '/settings');
            }, context),
            _buildDrawerItem(Icons.mood, 'Mood Tracker', () {
              Navigator.pop(context); // Close the drawer
              Navigator.pushNamed(context, '/mood_tracker');
            }, context),
            const Divider(),
            _buildDrawerItem(Icons.logout, 'Logout', () {
              Navigator.pop(context); // Close the drawer
              // TODO: Implement logout logic
              Navigator.pushReplacementNamed(context, '/auth_gateway');
            }, context),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Message
              Text(
                'Hi $_userName,', // Personalized greeting
                style: textTheme.headlineMedium?.copyWith(color: colorScheme.onBackground),
              ),
              Text(
                'How can I help you today?',
                style: textTheme.headlineSmall?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 20),

              // Daily Health Summary
              _buildSectionHeader('Daily Health Summary', Icons.local_hospital_outlined, colorScheme.tertiary, context),
              const SizedBox(height: 12),
              _buildCard(
                context: context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHealthSummaryRow(
                      Icons.check_circle_outline, 'Medications Taken',
                      '$_medsTakenToday / $_totalMedsToday', colorScheme.primary, textTheme, colorScheme,
                    ),
                    const SizedBox(height: 12),
                    _buildHealthSummaryRow(
                      Icons.sentiment_satisfied_alt, 'Last Logged Mood',
                      _lastMood, colorScheme.secondary, textTheme, colorScheme,
                    ),
                    const SizedBox(height: 12),
                    _buildHealthSummaryRow(
                      Icons.access_time_outlined, 'Next Medication',
                      '$_nextMedicationTime - $_nextMedicationName', colorScheme.primary, textTheme, colorScheme,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // New section: Talk to your Assistant
              _buildSectionHeader('Talk to your Assistant', Icons.chat_bubble_outline, colorScheme.primary, context),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/assistant_chat');
                  },
                  icon: Icon(Icons.mic, color: colorScheme.onPrimary),
                  label: Text(
                    'Start Chat with Assistant',
                    style: textTheme.labelLarge?.copyWith(color: colorScheme.onPrimary),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Dashboard Summary Cards
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  SummaryCard(
                    icon: Icons.access_time,
                    title: 'Next Medication',
                    value: '8:00 AM - Amoxicillin',
                    cardColor: colorScheme.tertiaryContainer,
                    iconColor: colorScheme.onTertiaryContainer,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Navigating to Next Medication details (TODO)')),
                      );
                      // TODO: Navigate to specific medication detail screen
                    },
                  ),
                  SummaryCard(
                    icon: Icons.close_rounded,
                    title: 'Missed Meds',
                    value: '3',
                    cardColor: colorScheme.errorContainer,
                    iconColor: colorScheme.onErrorContainer,
                    onTap: () {
                      Navigator.pushNamed(context, '/my_medications');
                    },
                  ),
                  SummaryCard(
                    icon: Icons.medication,
                    title: 'Total Active Meds',
                    value: '5',
                    cardColor: colorScheme.secondaryContainer,
                    iconColor: colorScheme.onSecondaryContainer,
                    onTap: () {
                      Navigator.pushNamed(context, '/my_medications');
                    },
                  ),
                  SummaryCard(
                    icon: Icons.calendar_today,
                    title: "Today's Progress",
                    value: '75%',
                    cardColor: colorScheme.primaryContainer,
                    iconColor: colorScheme.onPrimaryContainer,
                    onTap: () {
                      Navigator.pushNamed(context, '/summary_chart');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // View All Meds Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/my_medications');
                  },
                  icon: Icon(Icons.list_alt, color: colorScheme.onPrimary), // Using theme color
                  label: Text(
                    'View All Meds',
                    style: textTheme.labelLarge?.copyWith(color: colorScheme.onPrimary), // Using theme text style
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary, // Using theme color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return ListTile(
      leading: Icon(icon, color: colorScheme.primary), // Using theme color
      title: Text(
        title,
        style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface), // Using theme text style
      ),
      onTap: onTap,
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

  Widget _buildCard({required Widget child, required BuildContext context}) {
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

  Widget _buildHealthSummaryRow(IconData icon, String title, String value, Color iconColor, TextTheme textTheme, ColorScheme colorScheme) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                value,
                style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SummaryCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color cardColor;
  final Color iconColor;
  final VoidCallback onTap;

  const SummaryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.cardColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  State<SummaryCard> createState() => _SummaryCardState();
}

class _SummaryCardState extends State<SummaryCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()..scale(_isHovering ? 1.05 : 1.0),
          child: Card(
            color: widget.cardColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: _isHovering ? colorScheme.primary : Colors.transparent, // Highlight border on hover
                width: _isHovering ? 2 : 0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    widget.icon,
                    size: 36,
                    color: widget.iconColor, // Use provided icon color
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.title,
                    style: textTheme.bodyMedium?.copyWith(
                      color: widget.iconColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.value,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: widget.iconColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 