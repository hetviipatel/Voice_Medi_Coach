# Admin Panel & Referral Token System

## Overview

The Voice Medication Coach app now includes a comprehensive admin panel with a referral token system that allows health workers to register users with unique tokens and monitor their data in a tree-like structure.

## Features

### 🔐 Referral Token System
- **Unique Token Generation**: Health workers can generate unique 6-character referral tokens
- **Token Validation**: System validates tokens before user registration
- **Token Expiration**: Tokens expire after 30 days for security
- **One-time Use**: Each token can only be used once for registration

### 👥 User Management
- **Role-based Registration**: Users can register as 'User', 'Health Worker', or 'Admin'
- **Referral Token Requirement**: Users must provide a valid referral token during registration
- **Health Worker Assignment**: Users are automatically assigned to the health worker who generated their token
- **Hierarchical Structure**: Tree-like structure showing health worker → patient relationships

### 🏥 Health Worker Dashboard
- **Patient Management**: View and manage assigned patients
- **Token Generation**: Generate new referral tokens for patients
- **Patient Analytics**: Monitor medication adherence and health data
- **Communication**: Send messages to patients (planned feature)

### 📊 Admin Panel
- **User Management**: View, edit, and delete users
- **Token Management**: Monitor and manage all referral tokens
- **Analytics Dashboard**: View system-wide statistics and trends
- **Health Worker Performance**: Track health worker metrics

## File Structure

```
lib/
├── models/
│   └── user_model.dart              # User and ReferralToken models
├── screens/
│   ├── admin/
│   │   ├── admin_panel_screen.dart  # Main admin panel
│   │   ├── user_management_screen.dart
│   │   ├── referral_token_screen.dart
│   │   ├── health_worker_dashboard_screen.dart
│   │   └── analytics_screen.dart
│   └── auth/
│       └── signup_screen.dart       # Updated with referral token field
├── services/
│   └── referral_service.dart        # Referral token business logic
└── main.dart                        # Updated with admin panel routes
```

## User Roles

### 1. User
- **Registration**: Requires valid referral token from health worker
- **Features**: Access to medication tracking, reminders, and health monitoring
- **Data Sharing**: Health data is shared with assigned health worker

### 2. Health Worker
- **Registration**: Requires professional ID and specialization
- **Features**: 
  - Generate referral tokens for patients
  - View assigned patients and their health data
  - Monitor medication adherence
  - Access health worker dashboard

### 3. Admin
- **Features**:
  - Full system access
  - User management
  - Token management
  - Analytics and reporting
  - Health worker oversight

## How It Works

### 1. Health Worker Registration
1. Health worker registers with professional credentials
2. System creates health worker account
3. Health worker can access admin panel

### 2. Token Generation
1. Health worker navigates to admin panel
2. Generates referral tokens for patients
3. Tokens are unique 6-character codes (e.g., ABC123)
4. Tokens expire after 30 days

### 3. User Registration with Token
1. User receives referral token from health worker
2. User registers with name, email, password, and referral token
3. System validates token:
   - Checks if token exists
   - Verifies token hasn't been used
   - Confirms token hasn't expired
4. User is automatically assigned to the health worker who generated the token
5. Token is marked as used

### 4. Data Monitoring
1. Health worker can view all assigned patients
2. Patient health data is automatically shared with assigned health worker
3. Health worker can monitor medication adherence and health metrics
4. Tree-like structure shows health worker → patient relationships

## API Endpoints (Planned)

```dart
// Token Management
POST /api/tokens/generate
GET /api/tokens/health-worker/{id}
DELETE /api/tokens/{token}

// User Management
POST /api/users/register-with-token
GET /api/users/health-worker/{id}
PUT /api/users/{id}/health-data

// Analytics
GET /api/admin/statistics
GET /api/admin/user-hierarchy/{healthWorkerId}
```

## Database Schema (Planned)

### Users Table
```sql
CREATE TABLE users (
  id VARCHAR PRIMARY KEY,
  name VARCHAR NOT NULL,
  email VARCHAR UNIQUE NOT NULL,
  role ENUM('User', 'Health Worker', 'Admin') NOT NULL,
  referral_token VARCHAR,
  assigned_health_worker_id VARCHAR,
  professional_id VARCHAR,
  specialization VARCHAR,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE,
  health_data JSON
);
```

### Referral Tokens Table
```sql
CREATE TABLE referral_tokens (
  token VARCHAR PRIMARY KEY,
  generated_by VARCHAR NOT NULL,
  generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  expires_at TIMESTAMP,
  is_used BOOLEAN DEFAULT FALSE,
  used_by VARCHAR,
  used_at TIMESTAMP,
  FOREIGN KEY (generated_by) REFERENCES users(id),
  FOREIGN KEY (used_by) REFERENCES users(id)
);
```

## Security Features

1. **Token Validation**: Multiple validation checks before user registration
2. **Token Expiration**: Automatic expiration after 30 days
3. **One-time Use**: Tokens cannot be reused
4. **Role-based Access**: Different features for different user roles
5. **Data Isolation**: Health workers only see their assigned patients

## Future Enhancements

1. **QR Code Generation**: Generate QR codes for easy token sharing
2. **Bulk Token Generation**: Generate multiple tokens at once
3. **Advanced Analytics**: More detailed health metrics and trends
4. **Messaging System**: Direct communication between health workers and patients
5. **Mobile App for Health Workers**: Dedicated mobile interface
6. **API Integration**: Connect with existing healthcare systems
7. **Audit Logging**: Track all admin actions for compliance

## Usage Instructions

### For Health Workers
1. Register as a Health Worker with professional credentials
2. Access admin panel from home screen
3. Generate referral tokens for patients
4. Share tokens with patients
5. Monitor patient health data and adherence

### For Users
1. Obtain referral token from health worker
2. Register with token during signup
3. Use app normally - data is automatically shared with health worker

### For Admins
1. Access admin panel from home screen
2. View system-wide analytics and user management
3. Monitor health worker performance
4. Manage tokens and user accounts

## Technical Implementation

The system uses a singleton pattern for the ReferralService to maintain data consistency across the app. All data is currently stored in memory for demonstration purposes, but can be easily replaced with database/API calls.

The admin panel uses a tabbed interface for easy navigation between different functions, and the referral token system includes comprehensive validation and error handling. 