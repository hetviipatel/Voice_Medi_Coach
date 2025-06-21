import 'package:flutter/material.dart';
import 'package:voice_medication_coach/screens/rewards_screen.dart';

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

  // Mock daily reminders (replace with real data integration)
  final List<Map<String, dynamic>> _todaysReminders = [
    {
      'medication': 'Amoxicillin',
      'time': '8:00 AM',
      'description': 'Take with food',
      'isStarred': true,
      'isOn': true,
    },
    {
      'medication': 'Ibuprofen',
      'time': '12:30 PM',
      'description': '',
      'isStarred': false,
      'isOn': true,
    },
    {
      'medication': 'Metformin',
      'time': '6:00 PM',
      'description': 'Evening dose',
      'isStarred': false,
      'isOn': false,
    },
  ];

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
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? colorScheme.background : const Color(0xFFF7F9FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: null,
        title: Center(
          child: Text(
            'Track Your Health',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: colorScheme.primary),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Message
              Text(
                'Welcome to MediWell!',
                style: textTheme.headlineMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Your daily health companion',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 18),

              // Daily Reminders/Updates Block
              _buildDailyRemindersBlock(context),
              const SizedBox(height: 18),

              // Assistant Box
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: Theme.of(context).brightness == Brightness.dark
                      ? const LinearGradient(
                          colors: [Color(0xFF232B3A), Color(0xFF38F9D7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : const LinearGradient(
                          colors: [Color(0xFF43E97B), Color(0xFF38F9D7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  borderRadius: BorderRadius.circular(24),
                  border: null,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.black54 : const Color(0x3343E97B),
                      blurRadius: 16,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin: const EdgeInsets.only(bottom: 24),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withOpacity(0.12)
                            : const Color(0xFF43E97B).withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Icon(Icons.mic, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : const Color(0xFF009688), size: 32),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Talk to your Assistant',
                            style: textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : const Color(0xFF009688),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Ask about your meds, reminders, or anything else!',
                            style: textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : const Color(0xFF43E97B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/assistant_chat');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : const Color(0xFF009688),
                        foregroundColor: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF009688) : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      ),
                      child: Text('Start Chat', style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF009688) : Colors.white)),
                    ),
                  ],
                ),
              ),

              // Summary Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _SummaryGridCard(
                    icon: Icons.medication,
                    value: '7',
                    label: 'Upcoming Medications',
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF223A5E)
                        : const Color(0xFFD6E6FB),
                    onTap: () => Navigator.pushNamed(context, '/my_medications'),
                  ),
                  _SummaryGridCard(
                    icon: Icons.insert_chart,
                    value: '16',
                    label: 'Summary Chart',
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF1976D2)
                        : const Color(0xFFB3E5FC),
                    onTap: () => Navigator.pushNamed(context, '/summary_chart'),
                  ),
                  _SummaryGridCard(
                    icon: Icons.tips_and_updates,
                    value: '3',
                    label: 'Wellness Tips',
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF388E3C)
                        : const Color(0xFFC8E6C9),
                    onTap: () => Navigator.pushNamed(context, '/guidelines'),
                  ),
                  _SummaryGridCard(
                    icon: Icons.notifications,
                    value: '1',
                    label: 'New Notification',
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF7C4DFF)
                        : const Color(0xFFFFF9C4),
                    onTap: () => Navigator.pushNamed(context, '/reminders'),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              // Rewards Card/Button
              GestureDetector(
                    onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const RewardsScreen()));
                },
                child: Card(
                  color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF223A5E) : const Color(0xFF42A5F5),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.emoji_events, color: Colors.amber, size: 28),
                        const SizedBox(width: 12),
                        Text('View My Rewards', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Wellness Plan Section (now at bottom)
              Row(
                children: [
                  Icon(Icons.calendar_today, color: colorScheme.primary, size: 24),
                  const SizedBox(width: 10),
                  Text(
                    "Today's Wellness Plan",
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/reminders'),
                        child: _buildWellnessPlanRow(
                          context,
                          tag: 'View',
                          tagColor: const Color(0xFF42A5F5), // Vibrant blue
                          title: 'Medication Reminder',
                          titleColor: const Color(0xFF1565C0), // Deep blue
                          subtitle: '09:00 - 10:00',
                          icon: Icons.notifications_active,
                          iconColor: const Color(0xFF42A5F5),
                          trailing: Icon(Icons.check_circle, color: const Color(0xFF42A5F5), size: 22),
                        ),
                      ),
                      const SizedBox(height: 18),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/mood_tracker'),
                        child: _buildWellnessPlanRow(
                          context,
                          tag: 'Tips',
                          tagColor: const Color(0xFF66BB6A), // Vibrant green
                          title: 'MOOD TRACKER',
                          titleColor: const Color(0xFF2E7D32), // Deep green
                          subtitle: '13:00 - 14:30',
                          icon: Icons.emoji_emotions,
                          iconColor: const Color(0xFFFFB300), // Vibrant yellow
                          trailing: Icon(Icons.self_improvement, color: const Color(0xFFFFB300), size: 22),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: colorScheme.primary),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.list_alt, color: colorScheme.primary),
                onPressed: () {
                  Navigator.pushNamed(context, '/my_medications');
                },
              ),
              const SizedBox(width: 40), // space for FAB
              IconButton(
                icon: Icon(Icons.notifications, color: colorScheme.primary),
                onPressed: () {
                  Navigator.pushNamed(context, '/reminders');
                },
              ),
              IconButton(
                icon: Icon(Icons.person, color: colorScheme.primary),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example: Add new medication or quick action
          Navigator.pushNamed(context, '/add_edit_medication');
        },
        backgroundColor: colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        elevation: 6,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

  Widget _buildSummaryGridCard(BuildContext context, {required int index, required IconData icon, required String value, required String label}) {
    final textTheme = Theme.of(context).textTheme;
    final brightness = Theme.of(context).brightness;
    // Pastel colors for light mode, vibrant/dark for dark mode
    final List<Color> pastelColors = [
      const Color(0xFFD6E6FB), // Pastel blue
      const Color(0xFFB3E5FC), // Pastel light blue
      const Color(0xFFC8E6C9), // Pastel green
      const Color(0xFFFFF9C4), // Pastel yellow
    ];
    final List<Color> darkColors = [
      const Color(0xFF223A5E), // Deep navy blue
      const Color(0xFF1976D2), // Blue accent
      const Color(0xFF388E3C), // Green accent
      const Color(0xFF7C4DFF), // Deep purple for notification
    ];
    final Color cardColor = brightness == Brightness.dark
        ? darkColors[index % darkColors.length]
        : pastelColors[index % pastelColors.length];
    return Card(
      color: cardColor,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: brightness == Brightness.dark ? Colors.white : Colors.black54),
            const SizedBox(height: 10),
            Text(
              value,
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: brightness == Brightness.dark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: brightness == Brightness.dark ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWellnessPlanRow(BuildContext context, {required String tag, required Color tagColor, required String title, required Color titleColor, required String subtitle, required IconData icon, required Color iconColor, required Widget trailing}) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: tagColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(tag, style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        const SizedBox(width: 12),
        Icon(icon, color: iconColor, size: 26),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: titleColor)),
              Text(subtitle, style: textTheme.bodySmall?.copyWith(color: Colors.grey[700], fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        trailing,
      ],
    );
  }

  Widget _buildDailyRemindersBlock(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;
    // New gradient backgrounds
    final Gradient remindersGradient = isDark
        ? const LinearGradient(
            colors: [Color(0xFF6A4DFF), Color(0xFF232B3A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : const LinearGradient(
            colors: [Color(0xFFFFB347), Color(0xFFFFCC80)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          );
    final headerIconColor = isDark ? Color(0xFFFFCC80) : Color(0xFFEF6C00);
    final headerTextColor = isDark ? Colors.white : Colors.black87;
    final dotColor = headerIconColor;
    return Container(
      decoration: BoxDecoration(
        gradient: remindersGradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black54 : Color(0x33FFB347),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.notifications_active, color: headerIconColor, size: 26),
                const SizedBox(width: 10),
                Text(
                  "Today's Reminders",
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: headerTextColor,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (_todaysReminders.isEmpty)
              Text('No reminders for today!', style: textTheme.bodyMedium?.copyWith(color: headerTextColor.withOpacity(0.7))),
            ..._todaysReminders.where((r) => r['isOn'] == true).map((reminder) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.circle, color: dotColor, size: 12),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              reminder['medication'],
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: headerTextColor,
                              ),
                            ),
                            if (reminder['isStarred'] == true)
                              const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(Icons.star, color: Colors.amber, size: 18),
                              ),
                          ],
                        ),
                        Text(
                          reminder['time'],
                          style: textTheme.bodyMedium?.copyWith(
                            color: headerIconColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if ((reminder['description'] ?? '').isNotEmpty)
                          Text(
                            reminder['description'],
                            style: textTheme.bodySmall?.copyWith(
                              color: headerTextColor.withOpacity(0.8),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}

class _SummaryGridCard extends StatefulWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _SummaryGridCard({super.key, required this.icon, required this.value, required this.label, required this.color, required this.onTap});

  @override
  State<_SummaryGridCard> createState() => _SummaryGridCardState();
}

class _SummaryGridCardState extends State<_SummaryGridCard> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final brightness = Theme.of(context).brightness;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()..scale(_isHovering ? 1.045 : 1.0),
          decoration: BoxDecoration(
            boxShadow: _isHovering
                ? [
                    BoxShadow(
                      color: widget.color.withOpacity(0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Card(
            color: widget.color,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(widget.icon, size: 32, color: brightness == Brightness.dark ? Colors.white : Colors.black54),
                  const SizedBox(height: 10),
                  Text(
                    widget.value,
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: brightness == Brightness.dark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.label,
                    style: textTheme.bodyMedium?.copyWith(
                      color: brightness == Brightness.dark ? Colors.white70 : Colors.black54,
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