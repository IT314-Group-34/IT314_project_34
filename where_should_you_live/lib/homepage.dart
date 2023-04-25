import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();
}
class _HomepageState extends State<Homepage>{

  Widget func({required String url, required String value}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 200,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.lightBlue,
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
                      image: NetworkImage(url),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: MaterialButton(
              onPressed: () {},
              textColor: Colors.white,
              child: Text(value),
            ),
          ),
        ],
      ),
    );
  }


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
    return MaterialApp(
        home: Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.lightBlueAccent,
          child: ListView(
            children: [
              DrawerHeader(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      child: CircleAvatar(
                        radius: 46,
                        backgroundColor: Colors.lightBlue,
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
                          "User Full Name",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              list(icon: Icons.person, title: "View Profile"),
              list(icon: Icons.info, title: "About Us"),
              list(icon: Icons.contact_phone, title: "Contact Us"),
              list(icon: Icons.favorite, title: "Wishlist"),
              list(icon: Icons.feedback, title: "Feedback"),
              list(icon: Icons.settings, title: "Settings"),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Welcome To HomePage !',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: MaterialButton(
                color: Colors.tealAccent,
                onPressed: (){},
                textColor: Colors.white,
                child: Text('Log in'),
              ),
            ),
          )
        ],
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
                    func(
                        url:
                            'https://media.istockphoto.com/id/1190440285/photo/eclectic-living-room-interior-with-comfortable-velvet-corner-sofa-with-pillows.jpg?s=612x612&w=0&k=20&c=T87OfLSfrChREiVaDLJA4LIM2qvrc7UaosmxH75RY98=',
                        value: 'Buy Home'),
                    func(
                        url:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzb4zZup9NuwNt69CICu9YMjD2ynAqoiKkQx8-12Aiy82ZPdsy-4h0XMQFJoevNXFZsqw&usqp=CAU',
                        value: 'Search Neighbourhood'),
                    func(
                        url:
                            'https://media.istockphoto.com/id/1315159179/photo/happy-arabic-family-of-three-celebrating-success-with-laptop-at-home.jpg?b=1&s=170667a&w=0&k=20&c=IpPfXN33tbjBseLekbn3CiZNUeosYJmAc1qaq4zrciE=',
                        value: 'Add/Edit Profile Preference'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: const [
                  Text(
                    'Already Visited Neighbourhood ',
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
                    func(
                        url:
                            'https://img.staticmb.com/mbcontent//images/uploads/2022/12/Most-Beautiful-House-in-the-World.jpg',
                        value: 'Saved Neighbourhood'),
                    func(
                        url:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYvbFrWK1MxAmLPODPn9yiOzMPnCmUQKAKXw&usqp=CAU',
                        value: 'Liked Neighbourhood'),
                    func(
                        url:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdBctJ4n19vOP7rjTWw-9oUOE2oVpnuXxv-3ps5etHmpPx2NwCCOx0oCq3f7ZVZdBD8L4&usqp=CAU',
                        value: 'Give Feedback'),
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
