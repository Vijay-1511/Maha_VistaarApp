// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'user_model.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   // Login
//   Future<User?> login(String email, String password) async {
//     final credential = await _auth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return credential.user;
//   }

//   // Register
//   Future<User?> register(String name, String email, String password) async {
//     final credential = await _auth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );

//     User? user = credential.user;

//     if (user != null) {
//       UserModel newUser = UserModel(
//         uid: user.uid,
//         name: name,
//         email: email,
//       );

//       await _db.collection("users").doc(user.uid).set(newUser.toJson());
//     }

//     return user;
//   }

//   // Get current user
//   User? currentUser() {
//     return _auth.currentUser;
//   }

//   // Logout
//   Future<void> logout() async {
//     await _auth.signOut();
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maha_vistaar_app/data/auth/user_model.dart';
//import 'user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User?> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> register(String name, String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = credential.user;
      if (user != null) {
        final userModel = UserModel(uid: user.uid, name: name, email: email);
        await _db.collection('users').doc(user.uid).set(userModel.toJson());
      }
      return user;
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  User? currentUser() => _auth.currentUser;

  Future<void> logout() async => _auth.signOut();
}
