import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_medication_coach/screens/admin/user_management_screen.dart';
import 'package:voice_medication_coach/screens/admin/analytics_screen.dart';
import 'package:voice_medication_coach/screens/admin/health_worker_dashboard_screen.dart';
import 'package:voice_medication_coach/screens/admin/analytics_screen.dart';
import 'package:voice_medication_coach/screens/admin/setting_screen_admin.dart';
import 'package:voice_medication_coach/screens/admin/referral_token_screen.dart';
import 'package:voice_medication_coach/providers/theme_provider.dart';
import 'package:voice_medication_coach/providers/language_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'MediVoice Admin Panel',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      home: AdminPanelScreen(),
    );
  }
}

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HealthWorkerDashboard(),
    const UserManagementScreen(),
    const ReferralTokenScreen(),
    const AnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Health Worker Panel',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: colorScheme.primary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: colorScheme.primary),
            onPressed: () {
              // TODO: Implement logout
              Navigator.pushReplacementNamed(context, '/auth_gateway');
            },
          ),
        ],
      ),
      body: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      children: [
        // Mobile Navigation Tabs - More compact
        Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                color: colorScheme.outline.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildMobileNavItem(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  index: 0,
                ),
              ),
              Expanded(
                child: _buildMobileNavItem(
                  icon: Icons.people,
                  title: 'Patients',
                  index: 1,
                ),
              ),
              Expanded(
                child: _buildMobileNavItem(
                  icon: Icons.qr_code,
                  title: 'Tokens',
                  index: 2,
                ),
              ),
              Expanded(
                child: _buildMobileNavItem(
                  icon: Icons.analytics,
                  title: 'Analytics',
                  index: 3,
                ),
              ),
            ],
          ),
        ),
        // Main Content with proper mobile padding
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: _screens[_selectedIndex],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Row(
      children: [
        // Sidebar Navigation
        Container(
          width: 250,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(
              right: BorderSide(
                color: colorScheme.outline.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildNavItem(
                icon: Icons.dashboard,
                title: 'Dashboard',
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.people,
                title: 'Patient Management',
                index: 1,
              ),
              _buildNavItem(
                icon: Icons.qr_code,
                title: 'Referral Tokens',
                index: 2,
              ),
              _buildNavItem(
                icon: Icons.analytics,
                title: 'Analytics',
                index: 3,
              ),
              const Spacer(),
              // Health Worker Info
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: colorScheme.primary,
                      child: Icon(
                        Icons.medical_services,
                        color: colorScheme.onPrimary,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Health Worker',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Patient Management',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Main Content
        Expanded(
          child: _screens[_selectedIndex],
        ),
      ],
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isSelected = _selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? colorScheme.primaryContainer : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: textTheme.bodyLarge?.copyWith(
                    color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNavItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isSelected = _selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? colorScheme.primaryContainer : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                  size: 24,
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HealthWorkerDashboard extends StatelessWidget {
  const HealthWorkerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 8 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) ...[
            Text(
              'Health Worker Dashboard',
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
          ],
          
          // Statistics Cards
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: SizedBox(
              height: 400,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.3,
                physics: NeverScrollableScrollPhysics(),
                    children: [
                  _buildStatCard(context, title: 'Patients', value: '23', icon: Icons.people, color: Colors.blue),
                  _buildStatCard(context, title: 'Tokens', value: '12', icon: Icons.qr_code, color: Colors.green),
                  _buildStatCard(context, title: 'Adherence', value: '89%', icon: Icons.medication, color: Colors.orange),
                  _buildStatCard(context, title: 'New', icon: Icons.person_add, value: '3', color: Colors.purple),
                ],
              ),
                        ),
                      ),
          const SizedBox(height: 16),
          
          // Recent Activity
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Activity',
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 24),
                _buildActivityItem(
                  context,
                  'New patient registered with your token',
                  '2 minutes ago',
                  Icons.person_add,
                ),
                _buildActivityItem(
                  context,
                  'Generated 5 new referral tokens',
                  '15 minutes ago',
                  Icons.qr_code,
                ),
                _buildActivityItem(
                  context,
                  'Patient John Doe improved medication adherence',
                  '1 hour ago',
                  Icons.trending_up,
                ),
                _buildActivityItem(
                  context,
                  'Patient Sarah Smith missed medication reminder',
                  '2 hours ago',
                  Icons.warning,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Icon(icon, color: Colors.white, size: 32),
              ),
          SizedBox(height: 10),
          Flexible(
            child: Text(
            value,
              style: TextStyle(
                color: Colors.white,
              fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildActivityItem(BuildContext context, String title, String time, IconData icon) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.blue, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Text(
                  time,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 