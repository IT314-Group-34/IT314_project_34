import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:where_should_you_live/models/neibhorhood_model.dart'

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SearchPage(),
    );
  }
}

enum ExerciseFilter {
  Housing,
  Cost_of_Living,
  Startups,
  Venture_Capital,
  Travel_Connectivity,
  Commute,
  Business_Freedom,
  Safety,
  Healthcare,
  Education,
  Environmental_Quality,
  Economy,
  Taxation,
  Internet_Access,
  Leisure_and_Culture,
  Tolerance,
  Outdoors
}

//-----------------------------------------

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

//---------------------------------------

class _SearchPageState extends State<SearchPage> {
  static const historyLength = 5;

  // The "raw" history that we don't access from the UI, prefilled with values
  List<String> _searchHistory = [];

  // The filtered & ordered history that's accessed from the UI
  late List<String> filteredSearchHistory;
  final List<String> _filters = <String>[];

  List<String> filterSearchTerms({
    required String? filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      // Reversed because we want the last added items to appear first in the UI
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      // This method will be implemented soon
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }
    // Changes in _searchHistory mean that we have to update the filteredSearchHistory
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  // The currently searched-for term
  String? selectedTerm;
  late FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FloatingSearchBar(
        controller: controller,
        body: FloatingSearchBarScrollNotifier(
          child: SearchResultsListView(
            searchTerm: selectedTerm,
          ),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: BouncingScrollPhysics(),
        title: Text(selectedTerm ?? 'Search',
            style: Theme.of(context).textTheme.headline6),
        hint: 'What are you looking for...',
        actions: [FloatingSearchBarAction.searchToClear()],
        onQueryChanged: (query) => setState(
            () => filteredSearchHistory = filterSearchTerms(filter: query)),
        onSubmitted: (query) {
          setState(() {
            addSearchTerm(query);
            selectedTerm = query;
          });
          controller.close();
        },
        builder: (context, transition) {
          if (filteredSearchHistory.isEmpty && controller.query.isEmpty) {
            return Container(
              height: 56,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text('Start searching',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall),
            );
          } else if (filteredSearchHistory.isEmpty) {
            return ListTile(
              title: Text(controller.query),
              leading: const Icon(Icons.search),
              onTap: () {
                setState(() {
                  addSearchTerm(controller.query);
                  selectedTerm = controller.query;
                });
                controller.close();
              },
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: filteredSearchHistory
                  .map((term) => ListTile(
                        title: Text(term,
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                        leading: const Icon(Icons.history),
                        trailing: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () =>
                              setState(() => deleteSearchTerm(term)),
                        ),
                        onTap: () {
                          setState(() {
                            putSearchTermFirst(term);
                            selectedTerm = term;
                          });
                          controller.close();
                        },
                      ))
                  .toList(),
            );
          }
        },
      ),
    );
  }
}

//-----------------------------------------
class SearchResultsListView extends StatefulWidget {
  final String? searchTerm;

  const SearchResultsListView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  State<SearchResultsListView> createState() => _SearchResultsListViewState();
}

//-----------------------------------------


class _SearchResultsListViewState extends State<SearchResultsListView> {
  final List<String> _filters = <String>[];
  List<Map<int, dynamic>> _neighborDataList = [];
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    if (widget.searchTerm == null) {
      // Render the search filters and prompt.
      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 100,
              child: Wrap(
                spacing: 5.0,
                children: ExerciseFilter.values.map((ExerciseFilter exercise) {
                  return FilterChip(
                    label: Text(exercise.name),
                    selected: _filters.contains(exercise.name),
                    onSelected: (bool value) {
                      setState(() {
                        if (value) {
                          if (!_filters.contains(exercise.name)) {
                            _filters.add(exercise.name);
                          }
                        } else {
                          _filters.removeWhere((String name) {
                            return name == exercise.name;
                          });
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 400,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.search,
                      size: 64,
                    ),
                    Text(
                      'Start searching',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // Perform the search and update the list of neighborDataList.
      if (!_loading) {
        setState(() {
          _loading = true;
        });
        SearchService()
            .searchNeighborhoods(widget.searchTerm!, _filters)
            .then((List<Map<int, dynamic>> neighborData) {
          setState(() {
            _neighborDataList = neighborData;
            _loading = false;
          });
          print("Neighbor data: $_neighborDataList");
        }).catchError((error) {
          setState(() {
            _neighborDataList = [];
            _loading = false;
          });
        });
      }
    }

    // Render the list of search results.
    if (_loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (_neighborDataList.isEmpty) {
      return Center(
        child: Text('No results found.'),
      );
    } else {
      print("Building search results list");
      return ListView(
        padding: EdgeInsets.all(16),
        children: _neighborDataList
            .map((neighborData) => buildImageInteractionCard1(
                  neighborData['documentId'], 
                  neighborData['fullName'], 
                  neighborData['mobileImageLink'])
            )
            .toList(),
      );
    }
  }
}




class SearchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<int, dynamic>>> searchNeighborhoods(
      String searchQuery, List<String> filters) async {
    Query query = _firestore.collection('City');

    // Apply search query using where() method
    if (searchQuery != null && searchQuery.isNotEmpty) {
      query = query
          .where('fullName', isGreaterThanOrEqualTo: searchQuery)
          .where('fullName', isLessThan: searchQuery + 'z');
    }

    // Apply filters using orderBy() method
    if (filters != null && filters.isNotEmpty) {
      for (String filter in filters) {
        query = query.orderBy('categories.$filter.score_out_of_10', descending: true);
      }
    }

    try {
      QuerySnapshot querySnapshot = await query.get();
      List<Map<int, dynamic>> neighborhoods = [];
      for (DocumentSnapshot doc in querySnapshot.docs) {
        Map<int, dynamic> neighborhood = {
          int.tryParse(doc.id) ?? 0: {
            'fullName': (doc.data() as Map<String, dynamic>)['fullName'] as String,
            'mobileImageLink': (doc.data() as Map<String, dynamic>)['mobile_image_link'] as String,
          }
        };
        neighborhoods.add(neighborhood);
      }
      return neighborhoods;
    } catch (error) {
      print('Error in searchNeighborhoods: $error');
      return [];
    }
  }
}




Widget buildImageInteractionCard1(int documentId, String fullName, String mobileImageLink) {
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
              image: NetworkImage(mobileImageLink),
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
                fullName,
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
            documentId as String,
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
          ],
        )
      ],
    ),
  );
}





//---------------------------------------------


// class SearchAndFilterView extends StatefulWidget {
//   // ...
// }

// class _SearchAndFilterViewState extends State<SearchAndFilterView> {
//   TextEditingController _searchController = TextEditingController();
//   // Filter state variables


//   @override
//   Widget build(BuildContext context) {
//     // Build search bar and filter buttons
//   }
// }
