import 'package:flutter/material.dart';
import '../assets/constants/image_strings.dart';
import '../assets/constants/sizes.dart';
import '../assets/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //const TDefaultSize = 16.0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(TDefaultSize),
          child: Column(
            children: [
              Image(image: AssetImage(tWelcomeScreenImage)),
              Text(tLoginTitle,
                  style: Theme.of(context).textTheme.headlineLarge),
              Text(tLoginSubTitle,
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
