import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Future<UserCredential> signInWithGoogle(BuildContext context) async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication googleAuth =
//       await googleUser!.authentication;

//   // Create a new credential
//   final OAuthCredential credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );

//   // Once signed in, return the UserCredential
//   UserCredential userCredential =
//       await FirebaseAuth.instance.signInWithCredential(credential);
//   User? user = userCredential.user;
//   if (user != null) {
//     // Navigate to home page
//     Navigator.pushReplacementNamed(context, '/home');
//   }
//   return userCredential;
// }

Future<UserCredential> signInWithGoogle(BuildContext context) async {
  // Trigger the Google Authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

  // Create a new credential
  final OAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
  User? user = userCredential.user;
  if (user != null) {
    // Navigate to home page
    Navigator.pushReplacementNamed(context, '/home');
  }
  return userCredential;
}




Future<String?> signUpWithEmailAndPassword(
    BuildContext context, String email, String password) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;
    if (user != null) {
      // Navigate to home page
      Navigator.pushReplacementNamed(context, '/preference');
    }
    return null;
  } catch (e) {
    String errorMessage = 'An error occurred while signing up.';
    if (e is FirebaseAuthException) {
      // handle firebase authentication errors
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'Email already exists, please sign in instead.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address format.';
          break;
        case 'weak-password':
          errorMessage = 'Password must be at 6 characters long.';
          break;
      }
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return null;
  }
}

Future<void> loginWithEmail(
    BuildContext context, String email, String password) async {
  final FirebaseAuth verification = FirebaseAuth.instance;
  try {
    UserCredential userCredential = await verification
        .signInWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;
    if (user != null) {
      // Navigate to home page
      Navigator.pushReplacementNamed(context, '/home');
    }
  } on FirebaseAuthException catch (e) {
    String errorMessage;
    if (e.code == 'user-not-found') {
      errorMessage = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Wrong password provided for that user.';
    } else {
      errorMessage = 'An unknown error occurred.';
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
