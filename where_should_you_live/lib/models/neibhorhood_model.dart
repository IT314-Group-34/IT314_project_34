import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class CityData {
  String fullName;
  int geonameId;
  String geohash;
  double latitude;
  double longitude;
  int population;
  String mobileImageLink; // new field
  List<CategoryScore> categories;
  int numberOfUsers; // new field
  int rating;

  CityData({
    required this.fullName,
    required this.geonameId,
    required this.geohash,
    required this.latitude,
    required this.longitude,
    required this.population,
    required this.mobileImageLink,
    required this.categories,
    required this.numberOfUsers,
    required this.rating,
  });

  factory CityData.fromJson(Map<String, dynamic> json) {
    List<CategoryScore> categories = [];
    if (json['categories'] != null) {
      categories = (json['categories'] as List)
          .map((e) => CategoryScore.fromJson(e))
          .toList();
    }

    return CityData(
      fullName: json['full_name'] ?? '',
      geonameId: json['geoname_id'] ?? 0,
      geohash: json['location']['geohash'] ?? '',
      latitude: json['location']['latlon']['latitude'] ?? 0,
      longitude: json['location']['latlon']['longitude'] ?? 0,
      population: json['population'] ?? 0,
      mobileImageLink: '', // initialize to empty string
      categories: categories,
      numberOfUsers: 0, // initialize to zero
      rating: 0,
    );
  }

  factory CityData.fromJsondoc(Map<String, dynamic> json) {
    List<CategoryScore> categories = [];
    if (json['categories'] != null) {
      categories = (json['categories'] as List)
          .map((e) => CategoryScore.fromJson(e))
          .toList();
    }

    return CityData(
      fullName: json['fullName'] ?? '',
      geonameId: json['city_id'] ?? 0,
      geohash: json['geohash'] ?? '',
      latitude: json['latitude'] ?? 0,
      longitude: json['longitude'] ?? 0,
      population: json['population'] ?? 0,
      mobileImageLink: json['mobile_image_link'], // initialize to empty string
      categories: categories,
      numberOfUsers: json['numberOfUsers'], // initialize to zero
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'city_id': geonameId,
      'geohash': geohash,
      'latitude': latitude,
      'longitude': longitude,
      'population': population,
      'mobile_image_link': mobileImageLink, // add new field
      'categories': categories.map((e) => e.toJson()).toList(),
      'numberOfUsers': numberOfUsers, // initialize to zero
      'rating': rating,
    };
  }
}

class CategoryScore {
  String color;
  String name;
  double score;

  CategoryScore({
    required this.color,
    required this.name,
    required this.score,
  });

  factory CategoryScore.fromJson(Map<String, dynamic> json) {
    return CategoryScore(
      color: json['color'] ?? '',
      name: json['name'] ?? '',
      score: json['score_out_of_10'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'name': name,
      'score_out_of_10': score,
    };
  }
}

class CityService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference<Map<String, dynamic>> citiesCollection =
      FirebaseFirestore.instance.collection('City');

  var urbanAreaUrl;

  String toTitleCase(String str) {
    return str
        .toLowerCase()
        .split(' ')
        .map((word) => word.replaceFirst(word[0], word[0].toUpperCase()))
        .join(' ');
  }

  String toCamelCase(String str) {
    String titleCase = toTitleCase(str);
    return titleCase.replaceFirst(titleCase[0], titleCase[0].toLowerCase());
  }

  Future<CityData?> getCityData(String cityName) async {
    // Check if city data already exists in Firestore
    // Query for lowercase city name
    Query<Map<String, dynamic>> queryLowerCase = citiesCollection
        .where('fullName', isGreaterThanOrEqualTo: cityName.toLowerCase())
        .where('fullName',
            isLessThanOrEqualTo: '${cityName.toLowerCase()}\uf8ff');

// Query for uppercase city name
    Query<Map<String, dynamic>> queryUpperCase = citiesCollection
        .where('fullName', isGreaterThanOrEqualTo: cityName.toUpperCase())
        .where('fullName',
            isLessThanOrEqualTo: '${cityName.toUpperCase()}\uf8ff');

// Query for title case city name
    Query<Map<String, dynamic>> queryTitleCase = citiesCollection
        .where('fullName', isGreaterThanOrEqualTo: toTitleCase(cityName))
        .where('fullName',
            isLessThanOrEqualTo: '${toTitleCase(cityName)}\uf8ff');

// Query for camel case city name
    Query<Map<String, dynamic>> queryCamelCase = citiesCollection
        .where('fullName', isGreaterThanOrEqualTo: toCamelCase(cityName))
        .where('fullName',
            isLessThanOrEqualTo: '${toCamelCase(cityName)}\uf8ff');

// Execute the queries
    QuerySnapshot<Map<String, dynamic>> snapshotLowerCase =
        await queryLowerCase.get();
    QuerySnapshot<Map<String, dynamic>> snapshotUpperCase =
        await queryUpperCase.get();
    QuerySnapshot<Map<String, dynamic>> snapshotTitleCase =
        await queryTitleCase.get();
    QuerySnapshot<Map<String, dynamic>> snapshotCamelCase =
        await queryCamelCase.get();

// Check if any of the queries returned results
    if (snapshotLowerCase.docs.isNotEmpty) {
      DocumentSnapshot<Map<String, dynamic>> doc = snapshotLowerCase.docs.first;
      final data = doc.data();
      if (data != null) {
        return CityData.fromJsondoc(data);
      } else {
        return null;
      }
    } else if (snapshotUpperCase.docs.isNotEmpty) {
      DocumentSnapshot<Map<String, dynamic>> doc = snapshotUpperCase.docs.first;
      final data = doc.data();
      if (data != null) {
        return CityData.fromJsondoc(data);
      } else {
        return null;
      }
    } else if (snapshotTitleCase.docs.isNotEmpty) {
      DocumentSnapshot<Map<String, dynamic>> doc = snapshotTitleCase.docs.first;
      final data = doc.data();
      if (data != null) {
        return CityData.fromJsondoc(data);
      } else {
        return null;
      }
    } else if (snapshotCamelCase.docs.isNotEmpty) {
      DocumentSnapshot<Map<String, dynamic>> doc = snapshotCamelCase.docs.first;
      final data = doc.data();
      if (data != null) {
        return CityData.fromJsondoc(data);
      } else {
        return null;
      }
    } else {
      // City data does not exist in Firestore, call API to retrieve it and store it in Firestore
      final url =
          Uri.parse('https://api.teleport.org/api/cities/?search=$cityName');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final cityDataUrl = jsonData['_embedded']['city:search-results'][0]
            ['_links']['city:item']['href'];
        final cityDataResponse = await http.get(Uri.parse(cityDataUrl));
        if (cityDataResponse.statusCode == 200) {
          final cityDataJson = jsonDecode(cityDataResponse.body);
          final cityData = CityData.fromJson(cityDataJson);
          urbanAreaUrl = cityDataJson['_links']['city:urban_area']['href'];
          urbanAreaUrl = urbanAreaUrl + 'scores';
          // Call API to get category scores
          final categoriesUrl = Uri.parse(urbanAreaUrl);
          final categoriesResponse = await http.get(categoriesUrl);
          if (categoriesResponse.statusCode == 200) {
            final categoriesJson = jsonDecode(categoriesResponse.body);
            final categories = (categoriesJson['categories'] as List)
                .map((e) => CategoryScore.fromJson(e))
                .toList();
            cityData.categories = categories;
          }
          urbanAreaUrl = cityDataJson['_links']['city:urban_area']['href'];
          urbanAreaUrl = urbanAreaUrl + 'images';
          // Call API to get mobile image link
          final imagesUrl = Uri.parse(urbanAreaUrl);
          final imagesResponse = await http.get(imagesUrl);
          if (imagesResponse.statusCode == 200) {
            final imagesJson = jsonDecode(imagesResponse.body);
            final mobileImageLink = imagesJson['photos'][0]['image']['mobile'];
            cityData.mobileImageLink = mobileImageLink;
          }

          citiesCollection
              .doc(cityData.geonameId.toString())
              .set(cityData.toJson());
          return cityData;
        } else {
          return null;
        }
      } else {
        return null;
      }
    }
  }

  Future<List<Map<String, dynamic>>> getAllCitiesFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await citiesCollection.get();
    List<Map<String, dynamic>> cities = [];
    for (DocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
      final data = doc.data();
      if (data != null) {
        Map<String, dynamic> city = {
          'fullName': data['fullName'],
          'score': data['categories'],
          'userRating': data['rating'],
        };
        cities.add(city);
      }
    }
    return cities;
  }

  Future<void> updateCityData(CityData cityData) async {
    final docRef = citiesCollection.doc(cityData.geonameId.toString());
    final doc = await docRef.get();
    if (doc.exists) {
      // City data already exists in Firestore, update it
      await docRef.update(cityData.toJson());
    } else {
      // City data does not exist in Firestore, add it
      await docRef.set(cityData.toJson());
    }
  }

  Future<CityData?> getCityDataById(String cityId) async {
    // Get the CityData object from Firestore
    final docSnapshot =
        await FirebaseFirestore.instance.collection('City').doc(cityId).get();
    if (docSnapshot.exists) {
      final cityDataJson = docSnapshot.data()!;
      final cityData = CityData.fromJsondoc(cityDataJson);
      return cityData;
    } else {
      // City data does not exist in Firestore
      return null;
    }
  }
}

// Usage:
// Create a new CityService object
// final CityService cityService = CityService();

// // Initialize variables
// String cityName = '';
// CityData? cityData;

// // Define an asynchronous function to retrieve city data
// Future<void> _getCityData() async {
//   // Use the CityService object to get city data for the current city name
//   cityData = await cityService.getCityData(cityName);
  
//   // Trigger a UI update
//   setState(() {});
// }

// // Display the full name of the current city in the UI
// // (Assuming that cityData is not null)
// // ${cityData!.fullName}

//usage: getallcitydata
// final CityService _cityService = CityService();
//   late List<Map<String, dynamic>> _cities;

//   Future<void> _loadCities() async {
//     final cities = await _cityService.getAllCitiesFromFirestore();
//     setState(() {
//       _cities = cities;
//     });
//     city['categories'][0]['score_out_of_10'].toString()
//     city['name']
