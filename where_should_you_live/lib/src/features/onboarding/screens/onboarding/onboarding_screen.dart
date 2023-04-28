import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_should_you_live/src/features/onboarding/controllers/onboarding_controller.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:where_should_you_live/src/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen(
      {Key? key, required Future<void> Function() onLoggedIn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final obController = OnBoardingController();

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: obController.pages,
            enableSideReveal: true,
            liquidController: obController.controller,
            onPageChangeCallback: obController.onPageChangedCallback,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            waveType: WaveType.circularReveal,
          ),
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () => obController.skip(),
              child: const Text("Skip", style: TextStyle(color: Colors.black)),
            ),
          ),
          Obx(
            () => Positioned(
              bottom: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < obController.pages.length; i++)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: obController.currentPage.value == i
                            ? tDarkColor
                            : Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
