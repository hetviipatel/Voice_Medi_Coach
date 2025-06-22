import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String _selectedTimeRange = 'Last 30 Days';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 4 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            if (isMobile) ...[
              Text(
                'Analytics',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
            ] else ...[
              Text(
                'Analytics Dashboard',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
            ],
            
            // Time Range Selector
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: colorScheme.outline),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedTimeRange,
                  isExpanded: true,
                  items: ['Last 7 Days', 'Last 30 Days', 'Last 3 Months', 'Last Year']
                      .map((range) => DropdownMenuItem(
                            value: range,
                            child: Text(range),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedTimeRange = value!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: isMobile ? 8 : 16),
            
            // Key Metrics
            if (isMobile) ...[
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      'Total Patients',
                      '156',
                      '+12%',
                      Icons.people,
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: _buildMetricCard(
                      'Active Users',
                      '89',
                      '+8%',
                      Icons.person,
                      Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      'Adherence Rate',
                      '87%',
                      '+5%',
                      Icons.trending_up,
                      Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: _buildMetricCard(
                      'Tokens Used',
                      '234',
                      '+15%',
                      Icons.qr_code,
                      Colors.purple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ] else ...[
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      'Total Patients',
                      '156',
                      '+12%',
                      Icons.people,
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildMetricCard(
                      'Active Users',
                      '89',
                      '+8%',
                      Icons.person,
                      Colors.green,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildMetricCard(
                      'Medication Adherence Rate',
                      '87%',
                      '+5%',
                      Icons.trending_up,
                      Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildMetricCard(
                      'Referral Tokens Used',
                      '234',
                      '+15%',
                      Icons.qr_code,
                      Colors.purple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
            
            // Charts Section
            if (isMobile) ...[
              _buildChartCard(
                'User Registration Trend',
                _buildUserRegistrationChart(),
              ),
              const SizedBox(height: 16),
              _buildChartCard(
                'Token Usage Distribution',
                _buildTokenUsageChart(),
              ),
            ] else ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildChartCard(
                      'User Registration Trend',
                      _buildUserRegistrationChart(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildChartCard(
                      'Token Usage Distribution',
                      _buildTokenUsageChart(),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 32),
            
            // Health Worker Performance
            _buildChartCard(
              'Health Worker Performance',
              _buildHealthWorkerPerformanceTable(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String change, IconData icon, Color color) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(isMobile ? 6 : 8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: isMobile ? 18 : 24),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 6 : 8,
                  vertical: isMobile ? 2 : 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  change,
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: isMobile ? 10 : null,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 8 : 16),
          Text(
            value,
            style: (isMobile ? textTheme.titleMedium : textTheme.headlineMedium)?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: (isMobile ? textTheme.bodySmall : textTheme.bodyMedium)?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard(String title, Widget chart) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 12 : 24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: (isMobile ? textTheme.titleMedium : textTheme.titleLarge)?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: isMobile ? 8 : 16),
          chart,
        ],
      ),
    );
  }

  Widget _buildUserRegistrationChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBar(40, 'Mon'),
                _buildBar(60, 'Tue'),
                _buildBar(80, 'Wed'),
                _buildBar(120, 'Thu'),
                _buildBar(90, 'Fri'),
                _buildBar(70, 'Sat'),
                _buildBar(50, 'Sun'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(double height, String label) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      children: [
        Container(
          width: 30,
          height: height,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildTokenUsageChart() {
    return Container(
      height: 200,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '70%',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '30%',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text('Used Tokens'),
              const Spacer(),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text('Active Tokens'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHealthWorkerPerformanceTable() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final healthWorkers = [
      {'name': 'Dr. Sarah Smith', 'patients': 25, 'tokens': 8, 'adherence': 92},
      {'name': 'Dr. John Doe', 'patients': 18, 'tokens': 6, 'adherence': 88},
      {'name': 'Dr. Emily Johnson', 'patients': 32, 'tokens': 12, 'adherence': 95},
      {'name': 'Dr. Michael Brown', 'patients': 15, 'tokens': 5, 'adherence': 85},
    ];

    return Column(
      children: [
        // Table Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(flex: 3, child: Text('Health Worker', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold))),
              Expanded(flex: 1, child: Text('Patients', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold))),
              Expanded(flex: 1, child: Text('Tokens', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold))),
              Expanded(flex: 1, child: Text('Adherence', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Table Body
        ...healthWorkers.map((worker) => Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  worker['name'] as String,
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  worker['patients'].toString(),
                  style: textTheme.bodyMedium,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  worker['tokens'].toString(),
                  style: textTheme.bodyMedium,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getAdherenceColor(worker['adherence'] as int).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${worker['adherence']}%',
                    style: textTheme.bodySmall?.copyWith(
                      color: _getAdherenceColor(worker['adherence'] as int),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Color _getAdherenceColor(int adherence) {
    if (adherence >= 90) return Colors.green;
    if (adherence >= 80) return Colors.orange;
    return Colors.red;
  }
} 