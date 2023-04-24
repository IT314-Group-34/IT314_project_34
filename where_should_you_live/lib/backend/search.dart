// search_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'search_service.dart';

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

// The currently selected filters
Set<ExerciseFilter> _selectedFilters = {};

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
    final QuerySnapshot result = await _searchService.searchByCriteria(
      criteria,
      filters: _selectedFilters.toList(),
    );
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

return Scaffold(
      body: Column(
        children: [
          // Add a row of toggle buttons that allow the user to select which filters to apply
          Row(
            children: ExerciseFilter.values.map((filter) {
              return FilterChip(
                label: Text(filter.toString().split('.').last),
                selected: _selectedFilters.contains(filter),
                onSelected: (isSelected) {
                  setState(() {
                    if (isSelected) {
                      _selectedFilters.add(filter);
                    } else {
                      _selectedFilters.remove(filter);
                    }
                  });
                },
              );
            }).toList(),
          ),
          // Add additional widgets here to display the search results
        ],
      ),
    );
}
}
