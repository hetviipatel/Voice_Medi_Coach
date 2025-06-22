import 'package:flutter/material.dart';
import 'package:voice_medication_coach/models/user_model.dart';
import 'package:voice_medication_coach/screens/admin/setting_screen_admin.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();
  
  // Mock data - replace with actual data from backend
  final List<UserModel> _users = [
    UserModel(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      role: 'User',
      referralToken: 'ABC123',
      assignedHealthWorkerId: 'hw1',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      healthData: {'medicationAdherence': 85, 'lastCheckIn': '2024-01-15'},
    ),
    UserModel(
      id: '2',
      name: 'Dr. Sarah Smith',
      email: 'sarah@hospital.com',
      role: 'Health Worker',
      professionalId: 'MD12345',
      specialization: 'Cardiology',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      healthData: {'patientsCount': 25, 'activeTokens': 8},
    ),
    UserModel(
      id: '3',
      name: 'Jane Wilson',
      email: 'jane@example.com',
      role: 'User',
      referralToken: 'XYZ789',
      assignedHealthWorkerId: 'hw2',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      healthData: {'medicationAdherence': 92, 'lastCheckIn': '2024-01-16'},
    ),
  ];

  List<UserModel> get _filteredUsers {
    List<UserModel> filtered = _users;
    
    // Filter by role
    if (_selectedFilter != 'All') {
      filtered = filtered.where((user) => user.role == _selectedFilter).toList();
    }
    
    // Filter by search
    if (_searchController.text.isNotEmpty) {
      filtered = filtered.where((user) =>
        user.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
        user.email.toLowerCase().contains(_searchController.text.toLowerCase())
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
              'Patients',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
          ] else ...[
            Text(
              'Patient Management',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
          ],
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search patients...',
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
                      items: ['All', 'Active', 'Inactive']
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
          ),
          SizedBox(height: isMobile ? 8 : 16),
          
          // Users Table/List
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
                            Text('Patient List', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text('${_filteredUsers.length} patients found', style: textTheme.bodySmall),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(flex: 2, child: Text('Name', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold))),
                            Expanded(flex: 2, child: Text('Email', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold))),
                            Expanded(flex: 1, child: Text('Role', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold))),
                            Expanded(flex: 1, child: Text('Status', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold))),
                            Expanded(flex: 1, child: Text('Actions', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold))),
                          ],
                        ),
                  ),
                  
                  // Table Body
                  Expanded(
                    child: isMobile 
                      ? ListView.builder(
                          itemCount: _filteredUsers.length,
                          itemBuilder: (context, index) {
                            final user = _filteredUsers[index];
                            return _buildMobileUserCard(user, index);
                          },
                        )
                      : ListView.builder(
                          itemCount: _filteredUsers.length,
                          itemBuilder: (context, index) {
                            final user = _filteredUsers[index];
                            return _buildUserRow(user, index);
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

  Widget _buildUserRow(UserModel user, int index) {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                if (user.referralToken != null)
                  Text(
                    'Token: ${user.referralToken}',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              user.email,
              style: textTheme.bodyMedium,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getRoleColor(user.role).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                user.role,
                style: textTheme.bodySmall?.copyWith(
                  color: _getRoleColor(user.role),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: user.isActive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                user.isActive ? 'Active' : 'Inactive',
                style: textTheme.bodySmall?.copyWith(
                  color: user.isActive ? Colors.green : Colors.red,
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
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () => _showEditUserDialog(context, user),
                ),
                IconButton(
                  icon: const Icon(Icons.visibility, size: 20),
                  onPressed: () => _showUserDetails(context, user),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20),
                  onPressed: () => _showDeleteConfirmation(context, user),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'Health Worker':
        return Colors.blue;
      case 'User':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showAddUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddUserDialog(),
    );
  }

  void _showEditUserDialog(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) => EditUserDialog(user: user),
    );
  }

  void _showUserDetails(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) => UserDetailsDialog(user: user),
    );
  }

  void _showDeleteConfirmation(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Patient'),
        content: Text('Are you sure you want to delete ${user.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement delete user
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileUserCard(UserModel user, int index) {
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
              CircleAvatar(
                radius: 20,
                backgroundColor: colorScheme.primary,
                child: Text(
                  user.name[0].toUpperCase(),
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      user.email,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: user.role == 'Health Worker' 
                      ? Colors.blue.withOpacity(0.1) 
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  user.role,
                  style: textTheme.bodySmall?.copyWith(
                    color: user.role == 'Health Worker' ? Colors.blue : Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildUserInfo('Token', user.referralToken ?? 'N/A'),
              ),
              Expanded(
                child: _buildUserInfo('Joined', _formatDate(user.createdAt)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _viewUserDetails(user),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primaryContainer,
                    foregroundColor: colorScheme.onPrimaryContainer,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                  ),
                  child: Text(
                    'View',
                    style: textTheme.bodySmall?.copyWith(fontSize: 10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _editUser(user),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.secondaryContainer,
                    foregroundColor: colorScheme.onSecondaryContainer,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                  ),
                  child: Text(
                    'Edit',
                    style: textTheme.bodySmall?.copyWith(fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(String label, String value) {
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _viewUserDetails(UserModel user) {
    // TODO: Implement view user details
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('View details for ${user.name}')),
    );
  }

  void _editUser(UserModel user) {
    // TODO: Implement edit user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit user ${user.name}')),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key});

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String _selectedRole = 'User';
  String? _referralToken;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Patient'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) => value?.isEmpty == true ? 'Required' : null,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) => value?.isEmpty == true ? 'Required' : null,
            ),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              decoration: const InputDecoration(labelText: 'Role'),
              items: ['User', 'Health Worker']
                  .map((role) => DropdownMenuItem(value: role, child: Text(role)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedRole = value!),
            ),
            if (_selectedRole == 'User')
              TextFormField(
                decoration: const InputDecoration(labelText: 'Referral Token (Optional)'),
                onChanged: (value) => _referralToken = value,
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // TODO: Implement add user
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class EditUserDialog extends StatefulWidget {
  final UserModel user;
  
  const EditUserDialog({super.key, required this.user});

  @override
  State<EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit ${widget.user.name}'),
      content: const Text('Edit user functionality will be implemented here.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement edit user
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class UserDetailsDialog extends StatelessWidget {
  final UserModel user;
  
  const UserDetailsDialog({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Patient Details - ${user.name}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Email: ${user.email}'),
          Text('Role: ${user.role}'),
          Text('Created: ${user.createdAt.toString().split(' ')[0]}'),
          if (user.referralToken != null) Text('Referral Token: ${user.referralToken}'),
          if (user.professionalId != null) Text('Professional ID: ${user.professionalId}'),
          if (user.specialization != null) Text('Specialization: ${user.specialization}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
} 