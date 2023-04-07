import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Stream<FirebaseUser> firebaseListner =
      _firebaseAuth.onAuthStateChanged;

  static void firebaseSignIn(String email, String password) async {
    try {
      final _authResult = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print(_authResult.user.email);
      print(_authResult.user);
    } catch (e) {
      print(e);
    }
  }

  static void firebaseRegistration(String email, String password) async {
    try {
      final _authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(_authResult);
    } catch (e) {
      print(e);
    }
  }

  static Future<FirebaseUser> firebaseUserDetail() async =>
      await _firebaseAuth.currentUser();

  static void firebaseLogout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
