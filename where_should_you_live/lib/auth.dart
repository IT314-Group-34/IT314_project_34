import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle(BuildContext context) async {
  // Create a new provider
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
  googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

  // Once signed in, return the UserCredential
  UserCredential userCredential =
      await FirebaseAuth.instance.signInWithPopup(googleProvider);
  User? user = userCredential.user;
  if (user != null) {
    // Navigate to home page
    Navigator.pushReplacementNamed(context, '/home');
  }
  return userCredential;
  // Or use signInWithRedirect
  // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
}

// Future<UserCredential> signInWithGitHub() async {
//   // Create a new provider
//   GithubAuthProvider githubProvider = GithubAuthProvider();

//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithPopup(githubProvider);

//   // Or use signInWithRedirect
//   // return await FirebaseAuth.instance.signInWithRedirect(githubProvider);
// }

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
      Navigator.pushReplacementNamed(context, '/home');
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