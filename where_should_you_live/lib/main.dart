import 'package:flutter/material.dart';
import 'package:where_should_you_live/src/utils/theme/theme.dart';
import 'package:where_should_you_live/src/features/authentication/screens/onboarding/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(_buildMaterialApp());
}

MaterialApp _buildMaterialApp() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Where Should You Live?',
    theme: TAppTheme.lightTheme,
    darkTheme: TAppTheme.darkTheme,
    home: const OnBoardingScreen(),
  );
}
