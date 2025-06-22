class UserModel {
  final String id;
  final String name;
  final String email;
  final String role; // 'User', 'Health Worker'
  final String? referralToken; // Token given by health worker
  final String? assignedHealthWorkerId; // ID of the health worker who registered this user
  final String? professionalId; // For health workers
  final String? specialization; // For health workers
  final DateTime createdAt;
  final bool isActive;
  final Map<String, dynamic>? healthData; // User's health and medication data

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.referralToken,
    this.assignedHealthWorkerId,
    this.professionalId,
    this.specialization,
    required this.createdAt,
    this.isActive = true,
    this.healthData,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      referralToken: json['referralToken'],
      assignedHealthWorkerId: json['assignedHealthWorkerId'],
      professionalId: json['professionalId'],
      specialization: json['specialization'],
      createdAt: DateTime.parse(json['createdAt']),
      isActive: json['isActive'] ?? true,
      healthData: json['healthData'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'referralToken': referralToken,
      'assignedHealthWorkerId': assignedHealthWorkerId,
      'professionalId': professionalId,
      'specialization': specialization,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive,
      'healthData': healthData,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? referralToken,
    String? assignedHealthWorkerId,
    String? professionalId,
    String? specialization,
    DateTime? createdAt,
    bool? isActive,
    Map<String, dynamic>? healthData,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      referralToken: referralToken ?? this.referralToken,
      assignedHealthWorkerId: assignedHealthWorkerId ?? this.assignedHealthWorkerId,
      professionalId: professionalId ?? this.professionalId,
      specialization: specialization ?? this.specialization,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
      healthData: healthData ?? this.healthData,
    );
  }
}

class ReferralToken {
  final String token;
  final String generatedBy; // Health Worker ID
  final DateTime generatedAt;
  final DateTime? expiresAt;
  final bool isUsed;
  final String? usedBy; // User ID who used this token
  final DateTime? usedAt;

  ReferralToken({
    required this.token,
    required this.generatedBy,
    required this.generatedAt,
    this.expiresAt,
    this.isUsed = false,
    this.usedBy,
    this.usedAt,
  });

  factory ReferralToken.fromJson(Map<String, dynamic> json) {
    return ReferralToken(
      token: json['token'],
      generatedBy: json['generatedBy'],
      generatedAt: DateTime.parse(json['generatedAt']),
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
      isUsed: json['isUsed'] ?? false,
      usedBy: json['usedBy'],
      usedAt: json['usedAt'] != null ? DateTime.parse(json['usedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'generatedBy': generatedBy,
      'generatedAt': generatedAt.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'isUsed': isUsed,
      'usedBy': usedBy,
      'usedAt': usedAt?.toIso8601String(),
    };
  }
} 