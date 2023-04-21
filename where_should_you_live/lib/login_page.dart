import 'package:flutter/material.dart';
import 'package:where_should_you_live/src1/constants/image_strings.dart';
import 'package:where_should_you_live/src1/constants/sizes.dart';
import 'package:where_should_you_live/src1/constants/text_strings.dart';
//import '../assets/constants/image_strings.dart';
//import '../assets/constants/sizes.dart';
//import '../assets/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //const TDefaultSize = 16.0;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(TDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                    image: AssetImage(tWelcomeScreenImage),
                    height: size.height * 0.2),
                Text(tLoginTitle,
                    style: Theme.of(context).textTheme.headlineLarge),
                Text(tLoginSubTitle,
                    style: Theme.of(context).textTheme.bodySmall),
                Form(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              labelText: tEmail,
                              hintText: tEmail,
                              border: OutlineInputBorder()),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              labelText: tPassword,
                              hintText: tPassword,
                              border: OutlineInputBorder()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
