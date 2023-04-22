import 'package:flutter/material.dart';
import '../src1/constants/colors.dart';
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
              children: [
              const  FormHeaderWidget(
                  image: tWelcomeScreenImage,
                  title: tSignUpTitle,
                  subTitle: tSignUpSubTitle,
                ),
             Container(
               padding: const EdgeInsets.symmetric(vertical: tFormheight - 10),
               child: Form(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     TextFormField(
                         decoration: const InputDecoration(
                           label: Text(tFullName),
                          border: OutlineInputBorder(),
                           prefixIcon: Icon(
                               Icons.person_outline_outlined
                               //color: tSecondaryColor,
                           ),
                          // labelStyle: Textstyle(color:tSecondaryColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0 , color: tSecondaryColor)
                          )
                        ),
                     )
                   ],
                 ),
               ),
             )
                //const LoginForm(),
                // LoginFooterWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

