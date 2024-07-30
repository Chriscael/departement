// ignore_for_file: avoid_print, unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  bool _isLoggedIn = false;
  String _userType = '';

  bool get isLoggedIn => _isLoggedIn;
  String get userType => _userType;

  void checkLoginStatus() async {
    String? token = await storage.read(key: 'jwt');
    if (token != null) {
      _userType = await storage.read(key: 'userType') ?? '';
      _isLoggedIn = true;
      print("User is logged in as $_userType with token $token");
    } else {
      _isLoggedIn = false;
      _userType = '';
      print("User is not logged in");
    }
    notifyListeners();
  }

  // Future<void> logout() async {
  //   print("Attempting to delete JWT token...");
  //   await storage.delete(key: 'jwt');
  //   _isLoggedIn = false; // Make sure to update the logged-in state.
  //   print("JWT token deleted");
  //   notifyListeners(); // Notify all listening widgets of the change.
  // }

  Future<void> logout() async {
    print("Logging out...");
    await storage.delete(key: 'jwt');
    _isLoggedIn = false;
    _userType = '';
    notifyListeners();
    print("Logged out, navigating to sign-in page.");
  }
}

class GradeCountProvider with ChangeNotifier {
  Map<String, int> _gradeCounts = {};

  Map<String, int> get gradeCounts => _gradeCounts;

  void updateGradeCounts(Map<String, int> newCounts) {
    _gradeCounts = newCounts;
    notifyListeners();
  }
}
