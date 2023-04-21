# **IT314: Lab 8**

### Unit Testing For Log in
# **Group 34 Members**

| Sr. no. | Student Name | Student ID |
| --- | --- | --- |
| 1 | Aatman Shah | 202001064 |
| 2 | Fenil Dalwala | 202001130 |
| 3 | Aditya Nawal | 202001402 |
| 4 | Rohan Champaneri | 202001414 |
| 5 | Kashish Shroff | 202001425 |
| 6 | Het Patel | 202001434 |
| 7 | Parth Thakrar | 202001450 |
| 8 | Drashit Bhakhar | 202001453 |
| 9 | Nandini Parekh | 202001455 |
| 10 | Amol Patel | 202001456 |
| 11 | Smit Bhavsar | 202001464 |

### log in code
```
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Logging in with username: $_username and password: $_password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```
#### Test code for log_in 
```
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import './login_page.dart';

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

```
### Result 
![ss](https://user-images.githubusercontent.com/124344908/233697348-c930c549-35e3-486e-9a7b-77b636da26e5.jpeg)


