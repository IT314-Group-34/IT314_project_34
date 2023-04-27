import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'models/user_model.dart';
import 'models/neibhorhood_model.dart';
import 'neighborhood_details.dart';

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
        FirebaseUserRepository().getWishlist('aditya1234@gmail.com');
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
  bool _isSelected = false;
  bool _isWishlist = false;

  @override
  void initState() {
    super.initState();
    _cityDataFuture =
        CityService().getCityDataById(widget.cityId.replaceAll(' ', ''));
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
                        Text(cityData.rating.toStringAsFixed(1)),
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
