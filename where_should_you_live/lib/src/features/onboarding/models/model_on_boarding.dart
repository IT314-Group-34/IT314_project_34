import 'dart:ui';

import 'package:flutter/src/material/material_button.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String subTitle;
  final String counterText;
  final Color bgColor;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.counterText,
    required this.bgColor,
  });
}
