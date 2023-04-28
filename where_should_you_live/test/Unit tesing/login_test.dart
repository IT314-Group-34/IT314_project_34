import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:where_should_you_live/log_in.dart';
import '../../lib/auth.dart';

void main() {
  testWidgets('loginWithEmail test', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(LoginPage());

    // Find the email and password text fields
    final emailField = find.byKey(Key('email_field'));
    final passwordField = find.byKey(Key('password_field'));

    // Enter valid email and password in the text fields
    await tester.enterText(emailField, '202001450@daiict.ac.in');
    await tester.enterText(passwordField, '12345678');

    // Find and tap the login button
    final loginButton = find.byKey(Key('login_button'));
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Check if the user was redirected to the home page
    expect(find.text('Welcome To HomePage !'), findsOneWidget);
  });
}
