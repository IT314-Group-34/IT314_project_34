import 'package:flutter/material.dart';
import './signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './log_in.dart';




void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  runApp(MaterialApp(
    
    home: const MainApp(),
    routes: {
      '/signup': (context) => const MyApp(),
    },
  ));
}

class log_in extends StatelessWidget {
  const log_in ({Key? key}) : super(key: key);

  static const String _title = 'Sign in page';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: LoginPage(),
      ),
    );
  }
}

// Define a function to save user profile data to Firestore
Future<void> saveUserProfileDataToFirestore(String firstName, String lastName) async {
  final user = FirebaseAuth.instance.currentUser;
  final userProfileData = {
    'firstName': firstName,
    'lastName': lastName,
    'email': user.email,
    'photoUrl': user.photoURL,
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  };
  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .set(userProfileData, SetOptions(merge: true));
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _firstName = value!;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _lastName = value!;
                  });
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await saveUserProfileDataToFirestore(_firstName, _lastName);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Profile saved successfully!')),
                    );
                  }
                },
                child: Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: ElevatedButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MyApp()),
                      )
                    },
                child: const Text('Sign Up'))),
      ),
    );
  }
}
