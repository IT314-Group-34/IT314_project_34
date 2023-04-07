import 'package:flutter/material.dart';
// import 'package:where_should_you_live/core/configs/configs.dart';

class AppText {
  // static TextStyle? btn;

  // Headings
  static TextStyle? h1;
  static TextStyle? h1b;
  static TextStyle? h2;
  // static TextStyle? h2b;
  static TextStyle? h3;
  // static TextStyle? h3b;

  // Body
  // static TextStyle? b1;
  // static TextStyle? b1b;
  // static TextStyle? b2;
  // static TextStyle? b2b;

  // Label
  // static TextStyle? l1;
  // static TextStyle? l1b;
  // static TextStyle? l2;
  // static TextStyle? l2b;

  static init() {
    // const b = FontWeight.bold;
    const baseStyle = TextStyle(fontFamily: 'Poppins');

    h1 = baseStyle.copyWith(fontSize: 22);
    h1b = h1!.copyWith(fontWeight: FontWeight.w600);

    h2 = baseStyle.copyWith(fontWeight: FontWeight.w400);
    // h2b = h2!.copyWith(fontWeight: b);

    h3 = baseStyle.copyWith(fontWeight: FontWeight.w100);
    // h3b = h3!.copyWith(fontWeight: FontWeight.w100);

    // b1 = baseStyle.copyWith(fontSize: AppDimensions.font(10));
    // b1b = b1!.copyWith(fontWeight: b);

    // b2 = baseStyle.copyWith(fontSize: AppDimensions.font(8));
    // b2b = b2!.copyWith(fontWeight: b);

    // l1 = baseStyle.copyWith(fontSize: AppDimensions.font(6));
    // l1b = l1!.copyWith(fontWeight: b);

    // l2 = baseStyle.copyWith(fontSize: AppDimensions.font(4));
    // l2b = l2!.copyWith(fontWeight: b);
  }
}
