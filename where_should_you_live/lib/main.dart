import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:where_should_you_live/firebase_options.dart';
import 'package:where_should_you_live/homepage.dart';
import 'package:where_should_you_live/src/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'forgotPassword.dart';
import './sign_up.dart';
// import './login.dart';
import './preference_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    home: const OnBoardingScreen(),
    routes: {
      '/signup': (context) => SignUpPage(),
      // '/login': (context) => const Login(),
      '/onboarding': (context) => const OnBoardingScreen(),
      '/home': (context) => Homepage(),
      '/forgotPassword': (context) => ForgotPasswordScreen(),
    },
  ));
}

// class MyPreference extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Preference Page',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PreferencePage(),
//     );
//   }
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () => {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SignUpPage()),
//               )
//             },
//             child: const Text('Sign Up'),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Homepage'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () => {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SignUpPage()),
//                 )
//               },
//               child: const Text('Sign Up'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () => {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const Login()),
//                 ),
//               },
//               child: const Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
