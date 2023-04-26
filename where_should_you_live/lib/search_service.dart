import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:where_should_you_live/add_neighborhood_view.dart';

class SearchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> searchNeighborhoods(String searchQuery, /* filter information */) async {
    Query query = _firestore.collection('cities');
    // Apply filters using where() and orderBy() methods


    QuerySnapshot querySnapshot = await query.get();
    // Store neighborhood IDs
  }
}