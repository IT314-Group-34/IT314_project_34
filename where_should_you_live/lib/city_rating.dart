import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'models/neibhorhood_model.dart';
import 'neighborhood_details.dart';

final CityService cityService = CityService();
CityData? cityData;

class Citydata {
  final int? rating;
  final int? numberOfUsers;

  Citydata({this.rating, this.numberOfUsers});

  factory Citydata.fromJson(Map<String, dynamic> json) {
    return Citydata(
      rating: json['rating'] ?? 0,
      numberOfUsers: json['numberOfUsers'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating ?? 0,
      'numberOfUsers': numberOfUsers ?? 0,
    };
  }
}

class CityDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateSumAndCount(String cityName, int newSum, int newCount) async {
    try {
      cityData = await cityService.getCityData(cityName);
      final DocumentReference<Map<String, dynamic>> documentReference =
          _firestore.collection('City').doc(cityData!.geonameId.toString());
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await documentReference.get();

      if (documentSnapshot.exists) {
        final Citydata cityData = Citydata.fromJson(documentSnapshot.data()!);
        final int updatedSum = cityData.rating! + newSum;
        final int updatedCount = cityData.numberOfUsers! + newCount;
        await documentReference.update(Citydata(rating: updatedSum, numberOfUsers: updatedCount).toJson());
      } else {
        await documentReference.set(Citydata(rating: newSum, numberOfUsers: newCount).toJson());
      }
    } catch (e) {
      print('Error updating sum and count: $e');
    }
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}