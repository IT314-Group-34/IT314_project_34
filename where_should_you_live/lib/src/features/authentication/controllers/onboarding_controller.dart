import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:where_should_you_live/sign_up.dart';
import 'package:where_should_you_live/src/common_widgets/onboarding_widget.dart';
import 'package:where_should_you_live/src/features/authentication/models/model_on_boarding.dart';
import 'package:where_should_you_live/src/constants/text_strings.dart';
import 'package:where_should_you_live/src/constants/colors.dart';
import 'package:where_should_you_live/src/constants/image_strings.dart';

class OnBoardingController extends GetxController {
  final controller = LiquidController();
  RxInt currentPage = 0.obs;

  final pages = [
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: tOnBoardingImage1,
        title: tOnboardingTitle1,
        subTitle: tOnboardingSubTitle1,
        counterText: tOnboardingCounterText1,
        bgColor: tOnBoardingPage1Color,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: tOnBoardingImage2,
        title: tOnboardingTitle2,
        subTitle: tOnboardingSubTitle2,
        counterText: tOnboardingCounterText2,
        bgColor: tonBoardingPage2Color,
      ),
    ),
    OnBoardingPageWidget(
      model: OnBoardingModel(
        image: tOnboardingImage3,
        title: tOnboardingTitle3,
        subTitle: tOnboardingSubTitle3,
        counterText: tOnboardingCounterText3,
        bgColor: tOnBoardingPage3Color,
      ),
    ),
  ];

  skip() => controller.jumpToPage(page: 2);
  animateToNextSlide() {
    int nextPage = controller.currentPage + 1;
    controller.animateToPage(page: nextPage);
  }

  onPageChangedCallback(int activePageIndex) {
    currentPage.value = activePageIndex;
    if (activePageIndex == 2) {
      // Navigate to the signup page
      Get.to(() => SignUpPage());
    }
  }
}
