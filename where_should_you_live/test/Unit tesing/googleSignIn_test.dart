import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:where_should_you_live/auth.dart';

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  group('signInWithGoogle', () {
    late MockGoogleSignIn googleSignIn;
    late MockGoogleSignInAccount googleSignInAccount;
    late MockGoogleSignInAuthentication googleSignInAuthentication;
    late MockUserCredential userCredential;
    late BuildContext context;

    setUp(() {
      googleSignIn = MockGoogleSignIn();
      googleSignInAccount = MockGoogleSignInAccount();
      googleSignInAuthentication = MockGoogleSignInAuthentication();
      userCredential = MockUserCredential();
      context = MockBuildContext();
    });

    test('returns UserCredential on successful sign-in', () async {
      // arrange
      when(googleSignIn.signIn())
          .thenAnswer((_) => Future.value(googleSignInAccount));
      when(googleSignInAccount.authentication)
          .thenAnswer((_) => Future.value(googleSignInAuthentication));
      when(userCredential.user).thenReturn(FirebaseAuth.instance.currentUser);
      when(FirebaseAuth.instance.signInWithCredential(any))
          .thenAnswer((_) => Future.value(userCredential));
      when(Navigator.pushReplacementNamed(context, '/home')).thenReturn(null);

      // act
      final result = await signInWithGoogle(context);

      // assert
      expect(result, isA<UserCredential>());
    });
  });
}

BuildContext MockBuildContext() {}
