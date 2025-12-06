// import 'package:flutter/material.dart';
// import '../data/auth/auth_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthProvider extends ChangeNotifier {
//   final AuthService _authService = AuthService();

//   bool loading = false;
//   User? user;

//   Future<bool> login(String email, String password) async {
//     loading = true;
//     notifyListeners();

//     try {
//       user = await _authService.login(email, password);
//       loading = false;
//       notifyListeners();
//       return user != null;
//     } catch (e) {
//       loading = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   Future<bool> register(String name, String email, String password) async {
//     loading = true;
//     notifyListeners();

//     try {
//       user = await _authService.register(name, email, password);
//       loading = false;
//       notifyListeners();
//       return user != null;
//     } catch (e) {
//       loading = false;
//       notifyListeners();
//       return false;
//     }
//   }

//   void logout() async {
//     await _authService.logout();
//     user = null;
//     notifyListeners();
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maha_vistaar_app/data/auth_service.dart';
//import '../data/auth/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();

  bool loading = false;
  User? user;
  String? error;

  AuthProvider() {
    user = _service.currentUser();
  }

  Future<bool> login(String email, String password) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      user = await _service.login(email.trim(), password);
      loading = false;
      notifyListeners();
      return user != null;
    } on FirebaseAuthException catch (e) {
      loading = false;
      error = e.message;
      notifyListeners();
      return false;
    } catch (e) {
      loading = false;
      error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      user = await _service.register(name.trim(), email.trim(), password);
      loading = false;
      notifyListeners();
      return user != null;
    } on FirebaseAuthException catch (e) {
      loading = false;
      error = e.message;
      notifyListeners();
      return false;
    } catch (e) {
      loading = false;
      error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _service.logout();
    user = null;
    notifyListeners();
  }
}

