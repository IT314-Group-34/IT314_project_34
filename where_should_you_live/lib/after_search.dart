import 'After_search_neighbourhood_list/color_filters.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:where_should_you_live/models/neibhorhood_model.dart';


class SearchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> searchNeighborhoods(String searchQuery, List<String> filters, {List<String>? categories}) async {
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
    List<String> neighbourids = [];
    for (DocumentSnapshot doc in querySnapshot.docs) {
      neighbourids.add(doc.id);
    }

    if(neighbourids.isEmpty) {
      // add model function to check in api
      
    } else { 
      //call main function here with passing neighbourids
      runApp(MyApp(neighbourids: neighbourids));
    }
  }
}


// class MyApp extends StatelessWidget {
//   static final String title = 'Neighbourhood List';
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: title,
//         theme: ThemeData(primarySwatch: Colors.deepOrange),
//         home: MainPage(title: title),
//       );
// }
class MyApp extends StatelessWidget {
  static final String title = 'Neighbourhood List';
  final List<String> neighbourids;

  const MyApp({required this.neighbourids});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: MainPage(title: title, neighbourids: neighbourids),
      );
}
class MainPage extends StatefulWidget {
  final String title;
  final List<String> neighbourids;

  const MainPage({
    required this.title,
    required this.neighbourids,

  });


  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> neighbourids = [];

  @override
  void initState() {
    super.initState();
    neighbourids = widget.neighbourids;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            // buildQuoteCard(),
            buildListView(neighbourids),
          ],
        ),
      );
}


Widget buildListView(List<String> neighbourids) => ListView.builder(
  itemCount: neighbourids.length,
  itemBuilder: (context, index) {
    final neighborhood = neighbourids[index];
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



  Widget buildImageInteractionCard1(String neighborhoodId) {
  // Get the neighborhood data from Firestore
  final DocumentReference neighborhoodRef = FirebaseFirestore.instance.collection('cities').doc(neighborhoodId);
  return FutureBuilder<DocumentSnapshot>(
    future: neighborhoodRef.get(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text("Something went wrong");
      }
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> neighborhood = snapshot.data!.data() as Map<String, dynamic>;
        return Card(
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
                      neighborhood['mobile_image_link'],
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
                      neighborhood['name'],
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
                  'Address: ${neighborhood['address']}',
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
      }
      return CircularProgressIndicator();
    },
  );
}

// Widget buildImageInteractionCard1(List<String> neighborhood) => Card(
//       clipBehavior: Clip.antiAlias,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Column(
//         children: [
//           Stack(
//             children: [
//               Ink.image(
//                 image: NetworkImage(
//                   neighborhood.mobile_image_link,
//                 ),
//                 child: InkWell(
//                   onTap: () {},
//                 ),
//                 height: 240,
//                 fit: BoxFit.cover,
//               ),
//               Positioned(
//                 bottom: 16,
//                 right: 16,
//                 left: 16,
//                 child: Text(
//                   neighborhood.name,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontSize: 24,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.all(16).copyWith(bottom: 0),
//             child: Text(
//               'Address: ${neighborhood.address}',
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//           ButtonBar(
//             alignment: MainAxisAlignment.start,
//             children: [
//               MaterialButton(
//                 child: Text('More Details'),
//                 onPressed: () {},
//               ),
//               MaterialButton(
//                 child: Text('Wishlist'),
//                 onPressed: () {},
//               )
//             ],
//           )
//         ],
//       ),
//     );
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
