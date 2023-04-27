import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'models/user_model.dart';
import 'models/neibhorhood_model.dart';
import 'neighborhood_details.dart';
import 'package:provider/provider.dart';
import 'userProvider.dart';


String email='aditya1234@gmail.com';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(WishlistPage());
}


class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late Future<List<String>> _wishlistFuture;

  @override
  void initState() {
    super.initState();
    _wishlistFuture =
        FirebaseUserRepository().getWishlist(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: FutureBuilder<List<String>>(
        future: _wishlistFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return SelectableCard(
                  cityId: snapshot.data![index],
                  // Add any additional fields from the wishlist item here
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Center(child: Text('You have no items in your wishlist.'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class SelectableCard extends StatefulWidget {
  final String cityId;

  const SelectableCard({Key? key, required this.cityId}) : super(key: key);

  @override
  _SelectableCardState createState() => _SelectableCardState();
}

class _SelectableCardState extends State<SelectableCard> {
  late Future<CityData?> _cityDataFuture;
  final FirebaseUserRepository f1 = FirebaseUserRepository();
  bool _isSelected = false;
  bool _isWishlist = true;
  int id=0;
  double ratings=0;
  int users=0;
  int total=0;

  @override
  void initState() {
    super.initState();
    _cityDataFuture =
        CityService().getCityDataById(widget.cityId.replaceAll(' ', ''));
      id=int.parse(widget.cityId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NeighborhoodStatisticsPage(),
          ),
        );
      },
      child: Card(
        color: _isSelected
            ? Color.fromARGB(255, 231, 175, 106)
            : Color.fromARGB(255, 231, 175, 106),
        child: FutureBuilder<CityData?>(
          future: _cityDataFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final cityData = snapshot.data!;
              users=cityData.numberOfUsers;
              total=cityData.rating;
              ratings=total.toDouble() / users;
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(cityData.mobileImageLink),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _isWishlist = !_isWishlist;
                            });
                            if(!_isWishlist){
                             f1.removeFromWishlist(email, id);}
                             //setState(() {});
                             Navigator.push(
                            context,
                            MaterialPageRoute(
                       builder: (context) => WishlistPage(),
                        ),
                        );
                          },
                          icon: Icon(
                            _isWishlist
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _isWishlist ? Colors.red : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Text(
                          cityData.fullName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.star, color: Colors.yellow),
                        SizedBox(width: 5),
                        Text(ratings.toStringAsFixed(2)),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        _isSelected = !_isSelected;
                      });
                    },
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return ListTile(
                title: Text('City not found.'),
              );
            } else {
              return ListTile(
                title: Text('Loading city...'),
              );
            }
          },
        ),
      ),
    );
  }
}