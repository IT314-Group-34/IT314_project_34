import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'lib/login_page.dart';

void main() {
  testWidgets('LoginPage should log in with correct credentials', (WidgetTester tester) async {
    // Build the LoginPage widget
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Find the username and password fields, and the login button
    final Finder usernameField = find.byType(TextFormField).at(0);
    final Finder passwordField = find.byType(TextFormField).at(1);
    final Finder loginButton = find.widgetWithText(ElevatedButton, 'Login');

    // Fill in correct credentials and submit form
    await tester.enterText(usernameField, 'john.doe');
    await tester.enterText(passwordField, 'password');
    await tester.tap(loginButton);
    await tester.pump();

    // Check if we have successfully logged in
    expect(find.text('You are now logged in!'), findsOneWidget);
  });

  testWidgets('LoginPage should show error message with incorrect credentials', (WidgetTester tester) async {
    // Build the LoginPage widget
    await tester.pumpWidget(MaterialApp(home: LoginPage()));

    // Find the username and password fields, and the login button
    final Finder usernameField = find.byType(TextFormField).at(0);
    final Finder passwordField = find.byType(TextFormField).at(1);
    final Finder loginButton = find.widgetWithText(ElevatedButton, 'Login');

    // Fill in incorrect credentials and submit form
    await tester.enterText(usernameField, 'john.doe');
    await tester.enterText(passwordField, 'wrong_password');
    await tester.tap(loginButton);
    await tester.pump();

    // Check if we have an error message
    expect(find.text('Invalid username or password'), findsOneWidget);
  });
}
