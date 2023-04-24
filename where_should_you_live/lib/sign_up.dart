import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Where You Should Live?'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up Here!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        isDense: true,
                      ),
                      minLines: 1,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 16),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      onSaved: (value) {
// save the value to the username variable
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email Address',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        isDense: true,
                      ),
                      minLines: 1,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 16),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onSaved: (value) {
// save the value to the email variable
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        isDense: true,
                      ),
                      minLines: 1,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 16),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        if (!RegExp(r'[A-Z]').hasMatch(value)) {
                          return 'Password must contain at least one uppercase letter';
                        }
                        if (!RegExp(r'[0-9]').hasMatch(value)) {
                          return 'Password must contain at least one number';
                        }
                        if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
                          return 'Password must contain at least one special character (!,@,#,\$,&,*,~)';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            _formKey.currentState?.save();
                            // TODO: Implement sign-up logic
                          }
                        },
                        child: Text('Register'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
