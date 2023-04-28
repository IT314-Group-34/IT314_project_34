import 'package:flutter/material.dart';
import 'package:where_should_you_live/src/features/onboarding/models/model_on_boarding.dart';
import 'package:where_should_you_live/src/constants/sizes.dart';
import 'package:where_should_you_live/src/constants/text_theme.dart';


class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    Key? key,
    required this.model,
    this.button,
  }) : super(key: key);
  final OnBoardingModel model;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(TDefaultSize),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage(model.image),
            height: size.height * 0.45,
          ),
          Column(
            children: [
              Text(
                model.title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,

              ),
              Text(
                model.subTitle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Text(
            model.counterText,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          if (button != null) SizedBox(
  width: double.infinity,
  height: 60,
  child: ElevatedButton(
    onPressed: () {},
    child: button!,
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  ),
),
        ],
      ),
    );
  }
}
