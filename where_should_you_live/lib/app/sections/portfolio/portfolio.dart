import 'package:flutter/material.dart';
import 'portfolio_desktop.dart';
import 'portfolio_mobile.dart';
import 'package:where_should_you_live/core/res/responsive.dart';

class Portfolio extends StatelessWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: PortfolioMobileTab(),
      tablet: PortfolioMobileTab(),
      desktop: PortfolioDesktop(),
    );
  }
}
