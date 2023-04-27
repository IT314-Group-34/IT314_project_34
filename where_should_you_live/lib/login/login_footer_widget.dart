import 'package:flutter/material.dart';
import 'package:where_should_you_live/src1/constants/image_strings.dart';
import 'package:where_should_you_live/src1/constants/sizes.dart';
import 'package:where_should_you_live/src1/constants/text_strings.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
     const Text("OR"),
     const SizedBox(height: tFormheight-20,),
     SizedBox(
       width: double.infinity,
       child: OutlinedButton.icon(
           icon:Image(image :AssetImage(tGoogleLogoImage),width: 20,),
           onPressed: () {},
           label: Text(tSignInWithGoogle),
       ),
     ),
     const SizedBox(
       height: tFormheight-20,
       ),
     TextButton(
       onPressed: () {}, 
       child:const Text.rich(
             TextSpan(
             text: tDontHaveAnAccount,
             //style: Theme.of.(context).text.Theme.bodyText1,
             children: [
                TextSpan(
                 text: tSignup,
                 style: TextStyle(color: Colors.blue),
                )
             ],
            ),
         )
       ),
                  ],
                );
  }
}