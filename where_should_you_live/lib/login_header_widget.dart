import 'package:flutter/material.dart';
import 'package:where_should_you_live/src1/constants/image_strings.dart';
import 'package:where_should_you_live/src1/constants/sizes.dart';
import 'package:where_should_you_live/src1/constants/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            image: AssetImage(tWelcomeScreenImage),
            height: size.height * 0.2),
        Text(tLoginTitle,
            style: Theme.of(context).textTheme.headlineLarge),
        Text(tLoginSubTitle,
            style: Theme.of(context).textTheme.bodySmall),
      ],

    );
  }
}

