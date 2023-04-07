import 'package:flutter/material.dart';

import 'auth.dart';

void main() {
  runApp(const Login());
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _MyAppState();
}

class _MyAppState extends State<Login> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final formKey = GlobalKey<FormState>();
  @override
  initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool passenable = true;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login Screen'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Center(
                        child: MaterialButton(
                          minWidth: screenWidth * 0.3,
                          onPressed: () {
                            signInWithGoogle(context);
                          },
                          color: Colors.blue,
                          height: MediaQuery.of(context).size.height * 0.07,
                          textColor: Colors.white,
                          child: const Text('Log in With Google'),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      SizedBox(
                        width: screenWidth * 0.4,
                        child: const Divider(
                          color: Colors.black,
                          height: 25,
                          thickness: 2,
                          indent: 5,
                          endIndent: 5,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      SizedBox(
                        width: screenWidth * 0.4,
                        child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                              hintText: 'Enter Email Id',
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (String value) {},
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Please Enter Email Id'
                                  : null;
                            }),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      SizedBox(
                        width: screenWidth * 0.4,
                        child: TextFormField(
                            obscureText:
                                passenable, //if passenable == true, show **, else show password character
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              hintText: "Password",
                              labelText: "Enter Password",
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                              //eye icon if passenable = true, else, Icon is ***__
                            ),
                            onChanged: (String value) {},
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Please Enter password'
                                  : null;
                            }),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      MaterialButton(
                        minWidth: screenWidth * 0.3,
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            await loginWithEmail(context, _emailController.text,
                                _passwordController.text);
                          }
                        },
                        color: Colors.blue,
                        height: MediaQuery.of(context).size.height * 0.07,
                        textColor: Colors.white,
                        child: const Text('Log in'),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      TextButton(
                          onPressed: () => {
                                Navigator.pushReplacementNamed(
                                    context, '/forgotPassword'),
                              },
                          child: Text('Forgot Password?')),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      TextButton(
                          onPressed: () => {
                                Navigator.pushReplacementNamed(
                                    context, '/signup'),
                              },
                          child: Text('Don\'t have an account? Sign up.'))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
