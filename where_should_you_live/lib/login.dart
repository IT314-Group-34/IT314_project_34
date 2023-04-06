import 'package:flutter/material.dart';

void main() {
  runApp(const Login());
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _MyAppState();
}

class _MyAppState extends State<Login> {
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
            const Text(
              'Log in',
              style: TextStyle(
                fontSize: 35,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
              child: Form(
                  child: Column(
                children: [
                  Center(
                    child: MaterialButton(
                      minWidth: screenWidth * 0.3,
                      onPressed: () {},
                      color: Colors.blue,
                      height: MediaQuery.of(context).size.height * 0.07,
                      textColor: Colors.white,
                      child: const Text('Log in With Google'),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  SizedBox(
                    width: screenWidth * 0.4,
                    child: Divider(
                      color: Colors.black,
                      height: 25,
                      thickness: 2,
                      indent: 5,
                      endIndent: 5,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  SizedBox(
                    width: screenWidth * 0.4,
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
                          return value!.isEmpty
                              ? 'Please Enter Email Id'
                              : null;
                        }),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  SizedBox(
                    width: screenWidth * 0.4,
                    child: TextFormField(
                      obscureText:
                          passenable, //if passenable == true, show **, else show password character
                      decoration: const InputDecoration(
                        hintText: "Password",
                        labelText: "Enter Password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        //eye icon if passenable = true, else, Icon is ***__
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  MaterialButton(
                    minWidth: screenWidth * 0.3,
                    onPressed: () {},
                    color: Colors.blue,
                    height: MediaQuery.of(context).size.height * 0.07,
                    textColor: Colors.white,
                    child: const Text('Log in'),
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
