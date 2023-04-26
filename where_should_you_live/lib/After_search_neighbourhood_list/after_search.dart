import './color_filters.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:where_should_you_live/models/neibhorhood_model.dart';

void main() => runApp(MyApp());

class SearchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> searchNeighborhoods(String searchQuery, {List<String>? categories, required Function(List<String>) updateIds}) async {
    Query query = _firestore.collection('cities');

    // Apply filters using where() and orderBy() methods
    if (searchQuery != null && searchQuery.isNotEmpty) {
      query = query.where('fullName', isGreaterThanOrEqualTo: searchQuery)
                   .where('fullName', isLessThan: searchQuery + 'z');
    }
    if (categories != null && categories.isNotEmpty) {
      for (String category in categories) {
        query = query.orderBy('categories.$category', descending: true);
      }
    }

    QuerySnapshot querySnapshot = await query.get();
    // Store neighborhood IDs
    List<String> neighborhoodIds = [];
    for (DocumentSnapshot doc in querySnapshot.docs) {
      neighborhoodIds.add(doc.id);
    }

    if(neighborhoodIds.isEmpty) {
      // add model function to check in api
      
    } else {
      updateIds(neighborhoodIds);
    }
  }
}



class MyApp extends StatelessWidget {
  static final String title = 'Neighbourhood List';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> neighborhoodIds = [];

  void updateIds(List<String> ids) {
    setState(() {
      neighborhoodIds = ids;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            buildQuoteCard(),
            SearchService().searchNeighborhoods('search query', categories: ['category'], updateIds: updateIds),
            buildListView(neighborhoodIds),
          ],
        ),
      );
}


Widget buildListView(List<String> neighborhoodIds) => ListView.builder(
      itemCount: neighborhoodIds.length,
      itemBuilder: (context, index) {
        final neighborhood = neighborhoodIds[index];
        return buildImageInteractionCard1(neighborhood);
      },
    );

Widget buildQuoteCard() => Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose the neighbour before choosing the house',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );

Widget buildImageInteractionCard1(Neighborhood neighborhood) => Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Ink.image(
                image: NetworkImage(
                  neighborhood.mobile_image_link,
                ),
                child: InkWell(
                  onTap: () {},
                ),
                height: 240,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: Text(
                  neighborhood.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16).copyWith(bottom: 0),
            child: Text(
              'Address: ${neighborhood.address}',
              style: TextStyle(fontSize: 16),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              MaterialButton(
                child: Text('More Details'),
                onPressed: () {},
              ),
              MaterialButton(
                child: Text('Wishlist'),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
//   Widget buildImageInteractionCard3() => Card(
//         clipBehavior: Clip.antiAlias,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(24),
//         ),
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Ink.image(
//                   image: NetworkImage(
//                     'https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg',
//                   ),
//                   child: InkWell(
//                     onTap: () {},
//                   ),
//                   height: 240,
//                   fit: BoxFit.cover,
//                 ),
//                 Positioned(
//                   bottom: 16,
//                   right: 16,
//                   left: 16,
//                   child: Text(
//                     'House 3',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 24,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: EdgeInsets.all(16).copyWith(bottom: 0),
//               child: Text(
//                 'Address: \nNearest Hospital: \nNearest Railway Station: \nNearest School: ',
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//             ButtonBar(
//               alignment: MainAxisAlignment.start,
//               children: [
//                 MaterialButton(
//                   child: Text('More Details'),
//                   onPressed: () {},
//                 ),
//                 MaterialButton(
//                   child: Text('Wishlist'),
//                   onPressed: () {},
//                 )
//               ],
//             )
//           ],
//         ),
//       );
// }
