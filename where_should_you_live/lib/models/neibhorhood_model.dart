import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class CityData {
  final String fullName;
  final int geonameId;
  final String geohash;
  final double latitude;
  final double longitude;
  final int population;
  String mobileImageLink; // new field
  List<CategoryScore> categories;

  CityData({
    required this.fullName,
    required this.geonameId,
    required this.geohash,
    required this.latitude,
    required this.longitude,
    required this.population,
    required this.mobileImageLink,
    required this.categories,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': fullName,
      'city_id': geonameId,
      'latitude': latitude,
      'longitude': longitude,
      'population': population,
      'mobile_image_link': mobileImageLink, // add new field
      'categories': categories.map((e) => e.toJson()).toList(),
    };
  }
}

class CategoryScore {
  final String color;
  final String name;
  final double score;

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

  Future<CityData?> getCityData(String cityName) async {
    // Check if city data already exists in Firestore
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await citiesCollection.where('name', isEqualTo: cityName).get();
    if (querySnapshot.docs.isNotEmpty) {
      // City data already exists in Firestore, return it
      DocumentSnapshot<Map<String, dynamic>> doc = querySnapshot.docs.first;
      final data = doc.data();
      if (data != null) {
        return CityData.fromJson(data);
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

  Future<List<String>> getAllCityNamesFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await citiesCollection.get();
    List<String> cityNames = [];
    for (DocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
      final data = doc.data();
      if (data != null) {
        cityNames.add(data['name']);
      }
    }
    return cityNames;
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

