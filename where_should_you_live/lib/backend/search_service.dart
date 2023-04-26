import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:where_should_you_live/add_neighborhood_view.dart';


//main function to run this page
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategory;
  List<DocumentSnapshot> _cities = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
    _getCities();
  }

  void _getCities() async {
    Query query = FirebaseFirestore.instance.collection('cities');
    if (_searchQuery.isNotEmpty) {
      query = query.where('fullName', isGreaterThanOrEqualTo: _searchQuery).where('fullName', isLessThan: _searchQuery + 'z');
    }
    if (_selectedCategory != null) {
      query = query.orderBy('categories.$_selectedCategory', descending: true);
    }
    final cities = await query.get();
    setState(() {
      _cities = cities.docs;
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (category) {
              setState(() {
                _selectedCategory = category;
              });
              _getCities();
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Housing',
                child: Text('Housing'),
              ),
              PopupMenuItem(
                value: 'Cost of Living',
                child: Text('Cost of Living'),
              ),
              PopupMenuItem(
                value: 'Startups',
                child: Text('Startups'),
              ),
              PopupMenuItem(
                value: 'Venture Capital',
                child: Text('Venture Capital'),
              ),
              PopupMenuItem(
                value: 'Travel Connectivity',
                child: Text('Travel Connectivity'),
              ),
              PopupMenuItem(
                value: 'Commute',
                child: Text('Commute'),
              ),
              PopupMenuItem(
                value: 'Business Freedom',
                child: Text('Business Freedom'),
              ),
              PopupMenuItem(
                value: 'Safety',
                child: Text('Safety'),
              ),
              PopupMenuItem(
                value: 'Healthcare',
                child: Text('Healthcare'),
              ),
              PopupMenuItem(
                value: 'Education',
                child: Text('Education'),
              ),
              PopupMenuItem(
                value: 'Environmental Quality',
                child: Text('Environmental Quality'),
              ),
              PopupMenuItem(
                value: 'Economy',
                child: Text('Economy'),
              ),
              PopupMenuItem(
                value: 'Taxation',
                child: Text('Taxation'),
              ),
              PopupMenuItem(
                value: 'Internet Access',
                child: Text('Internet Access'),
              ),
              PopupMenuItem(
                value: 'Leisure & Culture',
                child: Text('Leisure & Culture'),
              ),
              PopupMenuItem(
                value: 'Tolerance',
                child: Text('Tolerance'),
              ),
              PopupMenuItem(
                value: 'Outdoors',
                child: Text('Outdoors'),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount:_cities.length,
        itemBuilder:(context,index){
          final city=_cities[index];
          return ListTile(title:
          Text(city['fullName']),
          );
        },
      )
    );
  }
}