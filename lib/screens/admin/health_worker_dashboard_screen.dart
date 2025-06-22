import 'package:flutter/material.dart';
import 'package:voice_medication_coach/models/user_model.dart';
import 'package:voice_medication_coach/screens/admin/setting_screen_admin.dart';
import 'package:provider/provider.dart';

class HealthWorkerDashboardScreen extends StatefulWidget {
  const HealthWorkerDashboardScreen({super.key});

  @override
  State<HealthWorkerDashboardScreen> createState() => _HealthWorkerDashboardScreenState();
}

class _HealthWorkerDashboardScreenState extends State<HealthWorkerDashboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  // Mock data - replace with actual data from backend
  final List<UserModel> _assignedPatients = [
    UserModel(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      role: 'User',
      referralToken: 'ABC123',
      assignedHealthWorkerId: 'hw1',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      healthData: {
        'medicationAdherence': 85,
        'lastCheckIn': '2024-01-15',
        'medications': ['Amoxicillin', 'Ibuprofen'],
        'nextAppointment': '2024-01-20',
      },
    ),
    UserModel(
      id: '2',
      name: 'Jane Wilson',
      email: 'jane@example.com',
      role: 'User',
      referralToken: 'XYZ789',
      assignedHealthWorkerId: 'hw1',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      healthData: {
        'medicationAdherence': 92,
        'lastCheckIn': '2024-01-16',
        'medications': ['Metformin', 'Aspirin'],
        'nextAppointment': '2024-01-25',
      },
    ),
  ];

  final List<ReferralToken> _generatedTokens = [
    ReferralToken(
      token: 'ABC123',
      generatedBy: 'hw1',
      generatedAt: DateTime.now().subtract(const Duration(days: 5)),
      isUsed: true,
      usedBy: 'user1',
      usedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    ReferralToken(
      token: 'DEF456',
      generatedBy: 'hw1',
      generatedAt: DateTime.now().subtract(const Duration(hours: 6)),
      isUsed: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Health Worker Dashboard',
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          
          // Statistics Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Assigned Patients',
                  _assignedPatients.length.toString(),
                  Icons.people,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Active Tokens',
                  _generatedTokens.where((t) => !t.isUsed).length.toString(),
                  Icons.qr_code,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Avg. Adherence',
                  '89%',
                  Icons.trending_up,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'Next Appointments',
                  '3',
                  Icons.calendar_today,
                  Colors.purple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          // Main Content Tabs
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: colorScheme.outline.withOpacity(0.2),
                      ),
                    ),
                    child: TabBar(
                      labelColor: colorScheme.primary,
                      unselectedLabelColor: colorScheme.onSurfaceVariant,
                      indicatorColor: colorScheme.primary,
                      tabs: const [
                        Tab(text: 'Patients'),
                        Tab(text: 'Tokens'),
                        Tab(text: 'Analytics'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildPatientsTab(),
                        _buildTokensTab(),
                        _buildAnalyticsTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              Text(
                title,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPatientsTab() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      children: [
        // Search Bar
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search patients...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onChanged: (value) => setState(() {}),
        ),
        const SizedBox(height: 16),
        
        // Patients List
        Expanded(
          child: ListView.builder(
            itemCount: _assignedPatients.length,
            itemBuilder: (context, index) {
              final patient = _assignedPatients[index];
              return _buildPatientCard(patient);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPatientCard(UserModel patient) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final adherence = patient.healthData?['medicationAdherence'] as int? ?? 0;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.06),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: colorScheme.primary,
                child: Text(
                  patient.name[0],
                  style: textTheme.headlineLarge?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
              ),
              const SizedBox(width: 22),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient.name,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      patient.email,
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: patient.role == 'User'
                      ? Colors.green.withOpacity(0.15)
                      : Colors.blue.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  patient.role,
                  style: textTheme.titleMedium?.copyWith(
                    color: patient.role == 'User' ? Colors.green : Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildPatientInfo(
                  'Medications',
                  (patient.healthData?['medications'] as List<dynamic>?)?.length.toString() ?? '0',
                  Icons.medication,
                ),
              ),
              Expanded(
                child: _buildPatientInfo(
                  'Last Check-in',
                  patient.healthData?['lastCheckIn'] as String? ?? 'N/A',
                  Icons.schedule,
                ),
              ),
              Expanded(
                child: _buildPatientInfo(
                  'Next Appointment',
                  patient.healthData?['nextAppointment'] as String? ?? 'N/A',
                  Icons.calendar_today,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _viewPatientDetails(patient),
                  icon: const Icon(Icons.visibility),
                  label: const Text('View Details'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _sendMessage(patient),
                  icon: const Icon(Icons.message),
                  label: const Text('Message'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPatientInfo(String label, String value, IconData icon) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      children: [
        Icon(icon, color: colorScheme.primary, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Color _getAdherenceColor(int adherence) {
    if (adherence >= 90) return Colors.green;
    if (adherence >= 80) return Colors.orange;
    return Colors.red;
  }

  Widget _buildTokensTab() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Generated Tokens',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _generateNewToken(),
              icon: const Icon(Icons.add),
              label: const Text('Generate Token'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        Expanded(
          child: ListView.builder(
            itemCount: _generatedTokens.length,
            itemBuilder: (context, index) {
              final token = _generatedTokens[index];
              return _buildTokenCard(token);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTokenCard(ReferralToken token) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.qr_code,
              color: colorScheme.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Token: ${token.token}',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
                Text(
                  'Generated: ${_formatDate(token.generatedAt)}',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: token.isUsed ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              token.isUsed ? 'Used' : 'Active',
              style: textTheme.bodySmall?.copyWith(
                color: token.isUsed ? Colors.green : Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return const Center(
      child: Text('Analytics will be implemented here'),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _viewPatientDetails(UserModel patient) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Patient Details - ${patient.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${patient.email}'),
            Text('Adherence: ${patient.healthData?['medicationAdherence']}%'),
            Text('Last Check-in: ${patient.healthData?['lastCheckIn']}'),
            Text('Next Appointment: ${patient.healthData?['nextAppointment']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _sendMessage(UserModel patient) {
    // TODO: Implement messaging functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Message feature will be implemented')),
    );
  }

  void _generateNewToken() {
    // TODO: Implement token generation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Token generation will be implemented')),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
} 