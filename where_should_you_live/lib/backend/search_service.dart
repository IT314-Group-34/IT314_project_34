import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByCriteria(String criteria, {int minRating = 0, int maxRating = 10}) {
    return FirebaseFirestore.instance
        .collection('neighbourhoods')
        .where('criteria', isEqualTo: criteria)
        .where('rating', isGreaterThanOrEqualTo: minRating)
        .where('rating', isLessThanOrEqualTo: maxRating)
        .get();
  }
}

// In your widget
// ...
final SearchService _searchService = SearchService();
List<DocumentSnapshot> _neighbourhoods = [];

void _searchNeighbourhoods(String criteria) async {
  final QuerySnapshot result = await _searchService.searchByCriteria(criteria);
  setState(() {
    _neighbourhoods = result.docs;
  });
}
// ...
