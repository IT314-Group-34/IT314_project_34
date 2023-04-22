import 'package:flutter/material.dart';
import '../assets/constants/image_strings.dart';
import '../assets/constants/sizes.dart';
import '../assets/constants/text_strings.dart';
import '../src1/constants/image_strings.dart';
import '../src1/constants/sizes.dart';
import '../src1/constants/text_strings.dart';
import 'signup_header_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(TDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                FormHeaderWidget(
                  image: tWelcomeScreenImage,
                  title: tSignUpTitle,
                  subTitle: tSignUpSubTitle,
                ),
                const LoginForm(),
                LoginFooterWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
