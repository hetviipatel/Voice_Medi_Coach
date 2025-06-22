import 'package:flutter/foundation.dart';

class UserService extends ChangeNotifier {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  String _currentUserRole = 'User';
  String _currentUserName = 'User';
  bool _isLoggedIn = false;

  String get currentUserRole => _currentUserRole;
  String get currentUserName => _currentUserName;
  bool get isLoggedIn => _isLoggedIn;
  bool get isHealthWorker => _currentUserRole == 'Health Worker';

  void login(String role, String name) {
    _currentUserRole = role;
    _currentUserName = name;
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _currentUserRole = 'User';
    _currentUserName = 'User';
    _isLoggedIn = false;
    notifyListeners();
  }

  void updateUserRole(String role) {
    _currentUserRole = role;
    notifyListeners();
  }
} 