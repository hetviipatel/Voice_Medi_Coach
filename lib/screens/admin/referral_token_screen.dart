import 'package:flutter/material.dart';
import 'package:voice_medication_coach/models/user_model.dart';
import 'dart:math';

class ReferralTokenScreen extends StatefulWidget {
  const ReferralTokenScreen({super.key});

  @override
  State<ReferralTokenScreen> createState() => _ReferralTokenScreenState();
}

class _ReferralTokenScreenState extends State<ReferralTokenScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  
  // Mock data - replace with actual data from backend
  final List<ReferralToken> _tokens = [
    ReferralToken(
      token: 'ABC123',
      generatedBy: 'hw1',
      generatedAt: DateTime.now().subtract(const Duration(days: 5)),
      isUsed: true,
      usedBy: 'user1',
      usedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    ReferralToken(
      token: 'XYZ789',
      generatedBy: 'hw2',
      generatedAt: DateTime.now().subtract(const Duration(days: 2)),
      isUsed: true,
      usedBy: 'user3',
      usedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    ReferralToken(
      token: 'DEF456',
      generatedBy: 'hw1',
      generatedAt: DateTime.now().subtract(const Duration(hours: 6)),
      isUsed: false,
    ),
    ReferralToken(
      token: 'GHI789',
      generatedBy: 'hw3',
      generatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      isUsed: false,
    ),
  ];

  List<ReferralToken> get _filteredTokens {
    List<ReferralToken> filtered = _tokens;
    
    // Filter by status
    if (_selectedFilter == 'Active') {
      filtered = filtered.where((token) => !token.isUsed).toList();
    } else if (_selectedFilter == 'Used') {
      filtered = filtered.where((token) => token.isUsed).toList();
    }
    
    // Filter by search
    if (_searchController.text.isNotEmpty) {
      filtered = filtered.where((token) =>
        token.token.toLowerCase().contains(_searchController.text.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: EdgeInsets.all(isMobile ? 4 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          if (isMobile) ...[
            Text(
              'Tokens',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
          ] else ...[
            Text(
              'Referral Token Management',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
          ],
          
          // Statistics Cards
          if (isMobile) ...[
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total',
                    _tokens.length.toString(),
                    Icons.qr_code,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _buildStatCard(
                    'Active',
                    _tokens.where((t) => !t.isUsed).length.toString(),
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _buildStatCard(
                    'Used',
                    _tokens.where((t) => t.isUsed).length.toString(),
                    Icons.done_all,
                    Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Total Tokens',
                    _tokens.length.toString(),
                    Icons.qr_code,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Active Tokens',
                    _tokens.where((t) => !t.isUsed).length.toString(),
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'Used Tokens',
                    _tokens.where((t) => t.isUsed).length.toString(),
                    Icons.done_all,
                    Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
          
          // Search and Filter Bar
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search tokens...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 8 : 16,
                      vertical: isMobile ? 8 : 12,
                    ),
                  ),
                ),
              ),
              SizedBox(width: isMobile ? 8 : 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.outline),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedFilter,
                    items: ['All', 'Active', 'Used']
                        .map((filter) => DropdownMenuItem(
                              value: filter,
                              child: Text(filter),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedFilter = value!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 8 : 16),
          
          // Tokens Table
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: colorScheme.outline.withOpacity(0.2),
                ),
              ),
              child: Column(
                children: [
                  // Table Header
                  Container(
                    padding: EdgeInsets.all(isMobile ? 12 : 16),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: isMobile 
                      ? Column(
                          children: [
                            Text('Token List', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text('${_filteredTokens.length} tokens found', style: textTheme.bodySmall),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(flex: 2, child: Text('Token', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold))),
                            Expanded(flex: 2, child: Text('Generated By', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold))),
                            Expanded(flex: 2, child: Text('Generated At', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold))),
                            Expanded(flex: 1, child: Text('Status', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold))),
                            Expanded(flex: 1, child: Text('Actions', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold))),
                          ],
                        ),
                  ),
                  
                  // Table Body
                  Expanded(
                    child: isMobile 
                      ? ListView.builder(
                          itemCount: _filteredTokens.length,
                          itemBuilder: (context, index) {
                            final token = _filteredTokens[index];
                            return _buildMobileTokenCard(token, index);
                          },
                        )
                      : ListView.builder(
                          itemCount: _filteredTokens.length,
                          itemBuilder: (context, index) {
                            final token = _filteredTokens[index];
                            return _buildTokenRow(token, index);
                          },
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
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: (isMobile ? textTheme.titleLarge : textTheme.headlineSmall)?.copyWith(
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
          ),
        ],
      ),
    );
  }

  Widget _buildMobileTokenCard(ReferralToken token, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.qr_code,
                  color: colorScheme.primary,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Token: ${token.token}',
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Generated: ${_formatDate(token.generatedAt)}',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: token.isUsed ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  token.isUsed ? 'Used' : 'Active',
                  style: textTheme.bodySmall?.copyWith(
                    color: token.isUsed ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.w600,
                    fontSize: 9,
                  ),
                ),
              ),
            ],
          ),
          if (token.isUsed) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildTokenInfo('Used by', token.usedBy ?? 'Unknown'),
                ),
                if (token.usedAt != null)
                  Expanded(
                    child: _buildTokenInfo('Used on', _formatDate(token.usedAt!)),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTokenRow(ReferralToken token, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isEven = index % 2 == 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isEven ? colorScheme.surface : colorScheme.surface.withOpacity(0.5),
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorScheme.primary.withOpacity(0.3)),
              ),
              child: Text(
                token.token,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Health Worker ${token.generatedBy}',
              style: textTheme.bodyMedium,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              _formatDate(token.generatedAt),
              style: textTheme.bodyMedium,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
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
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.copy, size: 20),
                  onPressed: () => _copyTokenToClipboard(token.token),
                ),
                IconButton(
                  icon: const Icon(Icons.qr_code, size: 20),
                  onPressed: () => _showQRCode(context, token),
                ),
                if (!token.isUsed)
                  IconButton(
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: () => _showDeleteConfirmation(context, token),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _copyTokenToClipboard(String token) {
    // TODO: Implement clipboard functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Token $token copied to clipboard')),
    );
  }

  void _showQRCode(BuildContext context, ReferralToken token) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('QR Code'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'QR Code for\n${token.token}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Token: ${token.token}'),
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

  void _showDeleteConfirmation(BuildContext context, ReferralToken token) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Token'),
        content: Text('Are you sure you want to delete token ${token.token}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement delete token
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showGenerateTokenDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const GenerateTokenDialog(),
    );
  }

  Widget _buildTokenInfo(String label, String value) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontSize: 9,
          ),
        ),
        Text(
          value,
          style: textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 10,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class GenerateTokenDialog extends StatefulWidget {
  const GenerateTokenDialog({super.key});

  @override
  State<GenerateTokenDialog> createState() => _GenerateTokenDialogState();
}

class _GenerateTokenDialogState extends State<GenerateTokenDialog> {
  int _tokenCount = 1;
  int _expiryDays = 30;
  String _generatedToken = '';

  @override
  void initState() {
    super.initState();
    _generateToken();
  }

  void _generateToken() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    _generatedToken = String.fromCharCodes(
      Iterable.generate(6, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Generate Referral Token'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text('Number of tokens: '),
              Expanded(
                child: Slider(
                  value: _tokenCount.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: _tokenCount.toString(),
                  onChanged: (value) {
                    setState(() {
                      _tokenCount = value.round();
                    });
                  },
                ),
              ),
              Text(_tokenCount.toString()),
            ],
          ),
          Row(
            children: [
              const Text('Expiry (days): '),
              Expanded(
                child: Slider(
                  value: _expiryDays.toDouble(),
                  min: 1,
                  max: 90,
                  divisions: 89,
                  label: _expiryDays.toString(),
                  onChanged: (value) {
                    setState(() {
                      _expiryDays = value.round();
                    });
                  },
                ),
              ),
              Text(_expiryDays.toString()),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              children: [
                Text(
                  'Sample Token:',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  _generatedToken,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: _generateToken,
                  child: const Text('Generate New Sample'),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement token generation
            Navigator.pop(context);
          },
          child: const Text('Generate'),
        ),
      ],
    );
  }
} 