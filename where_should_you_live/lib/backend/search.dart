// search_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'search_service.dart';

enum ExerciseFilter {
  filter_1,
  filter_2,
  filter_3,
  filter_4,
  filter_5,
  filter_6,
  filter_7,
  filter_8,
  filter_9
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const historyLength = 5;

// The "raw" history that we don't access from the UI, prefilled with values
  List<String> _searchHistory = [];
// The filtered & ordered history that's accessed from the UI
  late List<String> filteredSearchHistory;
  final List<String> _filters = <String>[];

  final SearchService _searchService = SearchService();
  List<DocumentSnapshot> _neighbourhoods = [];

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

// Call this method when the user submits a search query
void _searchNeighbourhoods(String criteria) async {
    final QuerySnapshot result =
        await _searchService.searchByCriteria(criteria);
    setState(() {
      _neighbourhoods = result.docs;
    });
}

@override
void initState() {
    super.initState();
    filteredSearchHistory = filterSearchTerms(filter: null);
}

@override
Widget build(BuildContext context) {
    // Build your UI here using the `_neighbourhoods` list to display the search results
}
}