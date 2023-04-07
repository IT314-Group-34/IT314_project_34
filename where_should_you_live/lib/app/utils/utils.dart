import 'package:flutter/material.dart';
import 'package:where_should_you_live/app/sections/contact/contact.dart';
import 'package:where_should_you_live/app/sections/home/home.dart';
import 'package:where_should_you_live/app/sections/portfolio/portfolio.dart';
import 'package:where_should_you_live/app/sections/services/services.dart';
import 'package:where_should_you_live/app/widgets/footer.dart';

class BodyUtils {
  static const List<Widget> views = [
    HomePage(),
    // About(),
    Services(),
    Portfolio(),
    Contact(),
    Footer(),
  ];
}
