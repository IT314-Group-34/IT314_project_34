import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:where_should_you_live/firebase_options.dart';
import 'package:where_should_you_live/homepage.dart';
import 'package:where_should_you_live/navigationBar.dart';
import 'package:where_should_you_live/profile.dart';
import 'package:where_should_you_live/src/features/onboarding/screens/onboarding/onboarding_screen.dart';
import 'package:where_should_you_live/wishlist.dart';
import 'forgotPassword.dart';
import './sign_up.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navigationBar.dart';
import 'userProvider.dart';
import 'package:provider/provider.dart';
// import './login.dart';
import './preference_page.dart';
import 'searchAndFilterView.dart';
import './wishlist.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        // Add additional providers here
      ],
      child: MyApp(),
    ),
  );
}

Future<bool> _checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  return isLoggedIn;
}

Future<void> _setLoginStatus(bool isLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return GetMaterialApp(
      // Replace MaterialApp with GetMaterialApp
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.data == true) {
            return navigationBar();
          } else {
            return OnBoardingScreen(
              onLoggedIn: () async {
                userProvider.email =
                    'user@example.com'; // Set the user's email address
                await _setLoginStatus(true);
              },
            );
          }
        },
      ),
      routes: {
        '/signup': (context) => SignUpPage(),
        '/SignUpPage': (context) => SignUpPage(),
        '/home': (context) => navigationBar(),
        '/forgotPassword': (context) => ForgotPasswordScreen(),
        '/preference': (context) => PreferencePage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
