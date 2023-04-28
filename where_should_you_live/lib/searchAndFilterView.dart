import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'models/neibhorhood_model.dart';
import 'neighborhood_details.dart';

enum ExerciseFilter {
  Housing,
  Cost_of_Living,
  Venture_Capital,
  Travel_Connectivity,
  Business_Freedom,
  Safety,
  Healthcare,
  Education,
  Environmental_Quality,
  Internet_Access,
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const historyLength = 5;

  List<String> _searchHistory = [];
  late List<String> filteredSearchHistory;
  final List<String> _filters = <String>[];

  List<String> filterSearchTerms({
    required String? filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }
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
        title: Text(
          selectedTerm ?? 'Search',
          style: Theme.of(context).textTheme.headline6,
        ),
        hint: 'What are you looking for...',
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) {
          setState(() {
            filteredSearchHistory = filterSearchTerms(filter: query);
          });
        },
        onSubmitted: (query) {
          setState(() {
            addSearchTerm(query);
            selectedTerm = query;
          });
          controller.close();
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Color.fromARGB(255, 236, 228, 228),
              elevation: 4,
              child: Builder(
                builder: (context) {
                  if (filteredSearchHistory.isEmpty &&
                      controller.query.isEmpty) {
                    return Container(
                      height: 56,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Start searching',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
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
                          .map(
                            (term) => ListTile(
                              title: Text(
                                term,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: const Icon(Icons.history),
                              trailing: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    deleteSearchTerm(term);
                                  });
                                },
                              ),
                              onTap: () {
                                setState(() {
                                  putSearchTermFirst(term);
                                  selectedTerm = term;
                                });
                                controller.close();
                              },
                            ),
                          )
                          .toList(),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class SearchResultsListView extends StatefulWidget {
  final String? searchTerm;

  const SearchResultsListView({
    Key? key,
    this.searchTerm,
  }) : super(key: key);

  @override
  _SearchResultsListViewState createState() => _SearchResultsListViewState();
}

class _SearchResultsListViewState extends State<SearchResultsListView> {
  late Future<CityData?> _futureCityData;
  late List<ExerciseFilter> items;
  late List<ExerciseFilter> filteredItems;
  final List<Color> cardColors = [
    Colors.green[100]!,
    Colors.red[100]!,
    Colors.blue[100]!,
    Colors.orange[100]!,
    Colors.purple[100]!,
    Colors.teal[100]!,
  ];

  @override
  void initState() {
    super.initState();
    _futureCityData = Future.value(null);
    if (widget.searchTerm != null) {
      _futureCityData =
          CityService().getCityData(widget.searchTerm!.replaceAll(' ', ''));
    }
    items = ExerciseFilter.values;
    filteredItems = items;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth / 2 - 16; // subtracting padding
    final cardHeight = cardWidth / 1.5;

    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: FutureBuilder<CityData?>(
        future: _futureCityData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final cityData = snapshot.data!;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('City data updated')),
              );
            });
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cityData.fullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                Image.network(
                  cityData.mobileImageLink,
                  height: 200.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            );
          } else {
            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: cardWidth / cardHeight,
              padding: const EdgeInsets.all(8.0), // add padding between cards
              mainAxisSpacing: 8.0, // add spacing between rows
              crossAxisSpacing: 8.0, // add spacing between columns
              children: List.generate(filteredItems.length, (index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilterDetailsPage(
                          filterName:
                              filteredItems[index].toString().split('.').last,
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Card(
                          color: cardColors[index % cardColors.length],
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              filteredItems[index]
                                  .toString()
                                  .split('.')
                                  .last
                                  .replaceAll('_', ' '),
                              style: const TextStyle(
                                fontSize: 16, // decrease font size
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
          }
        },
      ),
    );
  }
}

class FilterDetailsPage extends StatefulWidget {
  final String filterName;

  const FilterDetailsPage({
    Key? key,
    required this.filterName,
  }) : super(key: key);

  @override
  _FilterDetailsPageState createState() => _FilterDetailsPageState();
}

class _FilterDetailsPageState extends State<FilterDetailsPage> {
  late Future<List<Map<String, dynamic>>> _futureCityData;

  @override
  void initState() {
    super.initState();
    _futureCityData = _fetchCityData();
  }

  late int index;
  Future<List<Map<String, dynamic>>> _fetchCityData() async {
    // Fetch the city data from the Firestore database
    final snapshot = await FirebaseFirestore.instance.collection("City").get();

    // Parse the city data into a list of Map<String, dynamic> objects
    final cityData = snapshot.docs.map((doc) => doc.data()).toList();

    if (widget.filterName == "Housing") {
      // Sort the city data in descending order of score_out_of_10 in the categories array
      cityData.sort((a, b) => b["categories"][0]["score_out_of_10"]
          .compareTo(a["categories"][0]["score_out_of_10"]));
      index = 0;
    } else if (widget.filterName == "Cost_of_Living") {
      // Sort the city data in descending order of score_out_of_10 in the categories array
      cityData.sort((a, b) => b["categories"][1]["score_out_of_10"]
          .compareTo(a["categories"][1]["score_out_of_10"]));
      index = 1;
    } else if (widget.filterName == "Venture_Capital") {
      // Sort the city data in descending order of score_out_of_10 in the categories array
      cityData.sort((a, b) => b["categories"][3]["score_out_of_10"]
          .compareTo(a["categories"][3]["score_out_of_10"]));
      index = 3;
    } else if (widget.filterName == "Travel_Connectivity") {
      // Sort the city data in descending order of score_out_of_10 in the categories array
      cityData.sort((a, b) => b["categories"][4]["score_out_of_10"]
          .compareTo(a["categories"][4]["score_out_of_10"]));
      index = 4;
    } else if (widget.filterName == "Business_Freedom") {
      // Sort the city data in descending order of score_out_of_10 in the categories array
      cityData.sort((a, b) => b["categories"][6]["score_out_of_10"]
          .compareTo(a["categories"][6]["score_out_of_10"]));
      index = 6;
    } else if (widget.filterName == "Safety") {
      // Sort the city data in descending order of score_out_of_10 in the categories array
      cityData.sort((a, b) => b["categories"][7]["score_out_of_10"]
          .compareTo(a["categories"][7]["score_out_of_10"]));
      index = 7;
    } else if (widget.filterName == "Healthcare") {
      // Sort the city data in descending order of score_out_of_10 in the categories array
      cityData.sort((a, b) => b["categories"][8]["score_out_of_10"]
          .compareTo(a["categories"][8]["score_out_of_10"]));
      index = 8;
    } else if (widget.filterName == "Education") {
      // Sort the city data in descending order of score_out_of_10 in the categories array
      cityData.sort((a, b) => b["categories"][9]["score_out_of_10"]
          .compareTo(a["categories"][9]["score_out_of_10"]));
      index = 9;
    } else if (widget.filterName == "Environmental_Quality") {
      // Sort the city data in descending order of score_out_of_10 in the categories array
      cityData.sort((a, b) => b["categories"][10]["score_out_of_10"]
          .compareTo(a["categories"][10]["score_out_of_10"]));
      index = 10;
    } else if (widget.filterName == "Internet_Access") {
      // Sort the city data in descending order of score_out_of_10 in the categories array
      cityData.sort((a, b) => b["categories"][13]["score_out_of_10"]
          .compareTo(a["categories"][13]["score_out_of_10"]));
      index = 13;
    }

    return cityData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filterName),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureCityData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final cityData = snapshot.data!;
            return ListView.builder(
              itemCount: cityData.length,
              itemBuilder: (context, index) {
                return SelectableCard2(
                  cityId: cityData[index]['city_id'].toString(),
                  // Add any additional fields from the wishlist item here
                );
              },
            );
          } else {
            return const Center(
              child: Text("Failed to fetch city data"),
            );
          }
        },
      ),
    );
  }
}

class SelectableCard2 extends StatefulWidget {
  final String cityId;

  const SelectableCard2({Key? key, required this.cityId}) : super(key: key);

  @override
  _SelectableCardState createState() => _SelectableCardState();
}

class _SelectableCardState extends State<SelectableCard2> {
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
            builder: (context) => NeighborhoodStatisticsPage(sentString: '',),
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
