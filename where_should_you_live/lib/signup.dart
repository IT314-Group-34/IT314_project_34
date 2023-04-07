import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool passenable = true;
  final formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Signup Screen'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 35,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Center(
                        child: MaterialButton(
                          minWidth: 200,
                          onPressed: () {},
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: const Text('Sign Up With Google'),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const SizedBox(
                        width: 300,
                        child: Divider(
                          color: Colors.black,
                          height: 25,
                          thickness: 2,
                          indent: 5,
                          endIndent: 5,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                              hintText: 'Enter Name',
                              prefixIcon: Icon(Icons.text_fields),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (String value) {},
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                                return "Please Enter Correct Name";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                              hintText: 'Enter Email Id',
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (String value) {},
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                      .hasMatch(value!)) {
                                return "Please Enter Email Address";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                            //if passenable == true, show **, else show password character
                            controller: _pass,
                            decoration: const InputDecoration(
                                hintText: "Enter Password",
                                labelText: "Password",
                                prefixIcon: Icon(Icons.password),
                                border: OutlineInputBorder()
                                //eye icon if passenable = true, else, Icon is ***__
                                ),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                      .hasMatch(value!)) {
                                return "At Least 8 character Format : Abcd123@";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                            //if passenable == true, show **, else show password character
                            obscureText: passenable,
                            controller: _confirmPass,
                            decoration: const InputDecoration(
                              hintText: "Re-Enter Password",
                              labelText: "Confirm Password",
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(),
                              //eye icon if passenable = true, else, Icon is ***__
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Same as Password";
                              } else if (value != _pass.text) {
                                return "Please Enter Same as Password";
                              } else {
                                return null;
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        minWidth: 100,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final snackBar =
                                SnackBar(content: Text('creatin Account'));
                          }
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: const Text('Sign Up'),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
