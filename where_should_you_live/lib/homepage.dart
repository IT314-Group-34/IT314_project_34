import 'package:flutter/material.dart';
import 'package:where_should_you_live/searchAndFilterView.dart';
import 'package:where_should_you_live/wishlist.dart';
import 'userProvider.dart';
import 'package:provider/provider.dart';
import 'profile.dart';
import 'preference_page.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Widget list({required IconData icon, required String title}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 32,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return MaterialApp(
        home: Scaffold(
      drawer: Drawer(
        child: Container(
          color: Color.fromRGBO(232, 221, 252, 1.0),
          child: ListView(
            children: [
              DrawerHeader(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 50,
                      child: CircleAvatar(
                        radius: 46,
                        backgroundColor: Color.fromRGBO(232, 221, 252, 1.0),
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          userProvider.email,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ProfilePage()));
                  },
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                  ),
                ),
              ),
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => WishlistPage()));
                  },
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Wishlist'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Welcome To HomePage !',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromRGBO(29, 9, 93, 1.0),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_SeTuX-IkYKpD0bu89gts-yqP89hgozVWLA&usqp=CAU'),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 30, 0, 0),
                          child: Center(
                            child: Text(
                              'Home Is Not Just Place',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                          child: Center(
                            child: Text(
                              'It Is Emotion',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: const [
                  Text(
                    'Get Started With Exploring Real Estate Options',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 200,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(232, 221, 252, 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                Container(
                                  height: 165,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzb4zZup9NuwNt69CICu9YMjD2ynAqoiKkQx8-12Aiy82ZPdsy-4h0XMQFJoevNXFZsqw&usqp=CAU'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchPage()));
                              },
                              textColor: Colors.black,
                              child: Text('Search Neighbourhood'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 200,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(232, 221, 252, 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                Container(
                                  height: 165,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          'https://media.istockphoto.com/id/1315159179/photo/happy-arabic-family-of-three-celebrating-success-with-laptop-at-home.jpg?b=1&s=170667a&w=0&k=20&c=IpPfXN33tbjBseLekbn3CiZNUeosYJmAc1qaq4zrciE='),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PreferencePage()));
                              },
                              textColor: Colors.black,
                              child: Text('Add/Edit Profile Preference'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 200,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(232, 221, 252, 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                Container(
                                  height: 165,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        'https://img.staticmb.com/mbcontent//images/uploads/2022/12/Most-Beautiful-House-in-the-World.jpg',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WishlistPage()));
                              },
                              textColor: Colors.black,
                              child: Text('Saved Neighbourhood'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
