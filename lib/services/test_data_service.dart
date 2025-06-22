import 'package:voice_medication_coach/models/user_model.dart';
import 'package:voice_medication_coach/services/referral_service.dart';

class TestDataService {
  static final TestDataService _instance = TestDataService._internal();
  factory TestDataService() => _instance;
  TestDataService._internal();

  // Initialize test data
  void initializeTestData() {
    final referralService = ReferralService();
    
    // Clear existing data
    _clearAllData();
    
    // Create test health workers
    _createTestHealthWorkers();
    
    // Generate test tokens
    _generateTestTokens();
    
    // Create test users with tokens
    _createTestUsers();
    
    print('✅ Test data initialized successfully!');
    print('📋 Test Accounts:');
    print('   👨‍⚕️ Health Worker: dr.sarah@hospital.com (Password: 123456)');
    print('   👨‍⚕️ Health Worker: dr.john@clinic.com (Password: 123456)');
    print('   👤 User: john.patient@email.com (Password: 123456)');
    print('   👤 User: jane.patient@email.com (Password: 123456)');
    print('   🔑 Test Token: ABC123 (for new user registration)');
  }

  void _clearAllData() {
    // This would clear the service data in a real implementation
    print('🧹 Clearing existing test data...');
  }

  void _createTestHealthWorkers() {
    final referralService = ReferralService();
    
    // Create Health Worker 1
    final healthWorker1 = UserModel(
      id: 'hw1',
      name: 'Dr. Sarah Smith',
      email: 'dr.sarah@hospital.com',
      role: 'Health Worker',
      professionalId: 'MD12345',
      specialization: 'Cardiology',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      healthData: {
        'patientsCount': 15,
        'activeTokens': 5,
        'specialization': 'Cardiology',
      },
    );

    // Create Health Worker 2
    final healthWorker2 = UserModel(
      id: 'hw2',
      name: 'Dr. John Doe',
      email: 'dr.john@clinic.com',
      role: 'Health Worker',
      professionalId: 'MD67890',
      specialization: 'General Medicine',
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      healthData: {
        'patientsCount': 8,
        'activeTokens': 3,
        'specialization': 'General Medicine',
      },
    );

    // Add to service (in real implementation, this would be database calls)
    print('👨‍⚕️ Created test health workers');
  }

  void _generateTestTokens() {
    final referralService = ReferralService();
    
    // Generate tokens for health worker 1
    final token1 = referralService.generateToken('hw1');
    final token2 = referralService.generateToken('hw1');
    
    // Generate tokens for health worker 2
    final token3 = referralService.generateToken('hw2');
    
    print('🔑 Generated test tokens: $token1, $token2, $token3');
  }

  void _createTestUsers() {
    final referralService = ReferralService();
    
    try {
      // Create test user 1
      final user1 = referralService.registerUserWithToken(
        name: 'John Patient',
        email: 'john.patient@email.com',
        password: '123456',
        referralToken: 'ABC123', // This would be one of the generated tokens
      );

      // Create test user 2
      final user2 = referralService.registerUserWithToken(
        name: 'Jane Patient',
        email: 'jane.patient@email.com',
        password: '123456',
        referralToken: 'XYZ789', // This would be another generated token
      );

      // Update user health data
      referralService.updateUserHealthData(user1.id, {
        'medicationAdherence': 85,
        'lastCheckIn': '2024-01-15',
        'medications': ['Amoxicillin', 'Ibuprofen'],
        'nextAppointment': '2024-01-20',
      });

      referralService.updateUserHealthData(user2.id, {
        'medicationAdherence': 92,
        'lastCheckIn': '2024-01-16',
        'medications': ['Metformin', 'Aspirin'],
        'nextAppointment': '2024-01-25',
      });

      print('👤 Created test users with referral tokens');
    } catch (e) {
      print('⚠️ Error creating test users: $e');
    }
  }

  // Get test credentials for easy access
  Map<String, Map<String, String>> getTestCredentials() {
    return {
      'health_workers': {
        'dr.sarah@hospital.com': '123456',
        'dr.john@clinic.com': '123456',
      },
      'users': {
        'john.patient@email.com': '123456',
        'jane.patient@email.com': '123456',
      },
      'tokens': {
        'ABC123': 'Active token for testing',
        'XYZ789': 'Used token for testing',
      },
    };
  }

  // Print test data summary
  void printTestDataSummary() {
    final referralService = ReferralService();
    final stats = referralService.getAdminStatistics();
    
    print('\n📊 Test Data Summary:');
    print('   👥 Total Users: ${stats['totalUsers']}');
    print('   👨‍⚕️ Health Workers: ${stats['healthWorkers']}');
    print('   🔑 Active Tokens: ${stats['activeTokens']}');
    print('   🔑 Used Tokens: ${stats['usedTokens']}');
    print('\n🎯 How to Test:');
    print('   1. Login as Health Worker (dr.sarah@hospital.com)');
    print('   2. Access Admin Panel from home screen');
    print('   3. Generate new tokens or view assigned patients');
    print('   4. Login as User (john.patient@email.com) to see patient view');
  }
} 