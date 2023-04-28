import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import '../../lib/forgotPassword.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  group('ForgotPasswordScreen', () {
    late FirebaseAuth auth;

    setUp(() {
      auth = MockFirebaseAuth();
    });

    testWidgets('submitting empty form displays error', (tester) async {
      await tester.pumpWidget(MaterialApp(home: ForgotPasswordScreen()));

      final resetButton = find.text('Reset Password');
      expect(resetButton, findsOneWidget);

      await tester.tap(resetButton);
      await tester.pumpAndSettle();

      final snackBar = find.byType(SnackBar);
      expect(snackBar, findsOneWidget);

      final snackBarText = find.text('Please enter your email address');
      expect(snackBarText, findsOneWidget);
    });

    testWidgets('submitting valid form calls sendPasswordResetEmail',
        (tester) async {
      await tester.pumpWidget(MaterialApp(home: ForgotPasswordScreen()));

      final emailField = find.byType(TextFormField);
      expect(emailField, findsOneWidget);

      await tester.enterText(emailField, 'test@example.com');

      final resetButton = find.text('Reset Password');
      expect(resetButton, findsOneWidget);

      when(auth.sendPasswordResetEmail(email: 'test@example.com'))
          .thenAnswer((_) async => null);

      await tester.tap(resetButton);
      await tester.pumpAndSettle();

      verify(auth.sendPasswordResetEmail(email: 'test@example.com')).called(1);

      final snackBar = find.byType(SnackBar);
      expect(snackBar, findsOneWidget);

      final snackBarText = find.text('Password reset email sent');
      expect(snackBarText, findsOneWidget);
    });

    testWidgets('FirebaseAuthException displays error message in snackbar',
        (tester) async {
      await tester.pumpWidget(MaterialApp(home: ForgotPasswordScreen()));

      final emailField = find.byType(TextFormField);
      expect(emailField, findsOneWidget);

      await tester.enterText(emailField, 'test@example.com');

      final resetButton = find.text('Reset Password');
      expect(resetButton, findsOneWidget);

      final errorMessage = 'Invalid email address';

      when(auth.sendPasswordResetEmail(email: 'test@example.com'))
          .thenThrow(FirebaseAuthException(message: errorMessage, code: ''));

      await tester.tap(resetButton);
      await tester.pumpAndSettle();

      final snackBar = find.byType(SnackBar);
      expect(snackBar, findsOneWidget);

      final snackBarText = find.text(errorMessage);
      expect(snackBarText, findsOneWidget);
    });
  });
}
