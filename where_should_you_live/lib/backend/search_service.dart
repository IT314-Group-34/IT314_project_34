// search_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

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

class SearchService {
  searchByCriteria(String criteria,
      {int minRating = 0,
      int maxRating = 10,
      List<ExerciseFilter> filters = const []}) {
    Query query = FirebaseFirestore.instance
        .collection('neighbourhoods')
        .where('criteria', isEqualTo: criteria)
        .where('rating', isGreaterThanOrEqualTo: minRating)
        .where('rating', isLessThanOrEqualTo: maxRating);

    // Apply the filters to the query
    for (final filter in filters) {
      switch (filter) {
        case ExerciseFilter.filter_1:
          // Add a where clause to the query for filter_1
          query = query.where('filter_1', isEqualTo: true);
          break;
        case ExerciseFilter.filter_2:
          // Add a where clause to the query for filter_2
          query = query.where('filter_2', isEqualTo: true);
          break;
        // Add additional cases here for the other filters
      }
    }

    return query.get();
  }
}