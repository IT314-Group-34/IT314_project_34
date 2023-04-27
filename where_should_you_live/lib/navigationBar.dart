import 'package:flutter/material.dart';
import 'main.dart';
import 'wishlist.dart';
import 'homepage.dart';
import 'models/user_model.dart';
import 'searchAndFilterView.dart';
import 'profile.dart';
import 'firebase_options.dart';
import 'userProvider.dart';
import 'package:provider/provider.dart';

class navigationBar extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<navigationBar> {
  int _selectedIndex = 0;

  final screens = [
    Homepage(),
    SearchPage(),
    ProfilePage(),
    WishlistPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    print(userProvider.email);
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: screens[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Wishlist',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedFontSize: 16.0, // set selected item font size
          unselectedFontSize: 14.0, // set unselected item font size
          type: BottomNavigationBarType
              .fixed, // set type to fixed for more than 3 items
          elevation: 5.0,
          // add shadow
        ),
      ),
    );
  }
}
