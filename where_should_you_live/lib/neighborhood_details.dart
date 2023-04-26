import 'package:flutter/material.dart';
import 'package:where_should_you_live/login.dart';
import 'neigborhood_model.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';

class RatingWidget extends StatefulWidget {
  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  int _rating = 0;

  void _onRatingChanged(int rating) {
    setState(() {
      _rating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City Rating'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Text(
                  '$_rating',
                  style: TextStyle(fontSize: 18),
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Rate your City:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 1; i <= 5; i++)
                  InkWell(
                    onTap: () => _onRatingChanged(i),
                    child: Icon(
                      Icons.star,
                      size: 36,
                      color: _rating >= i ? Colors.yellow : Colors.grey,
                    ),
                  ),
              ],
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NeighborhoodStatisticsPage()),
                )
              },
              child: const Text('SUBMIT'),
            ),

          ],
        ),
      ),
    );
  }
}


class NeighborhoodStatistics {
  final String factor;
  final int rating;

  NeighborhoodStatistics(this.factor, this.rating);
}

//
class NeighborhoodStatisticsChart extends StatefulWidget {
  final List<NeighborhoodStatistics> data;

  NeighborhoodStatisticsChart({required this.data});

  @override
  _NeighborhoodStatisticsChartState createState() => _NeighborhoodStatisticsChartState();
}

class _NeighborhoodStatisticsChartState extends State<NeighborhoodStatisticsChart> {
  
  final CityService cityService = CityService();
  String cityName = 'Delhi';
  CityData? cityData;


  @override
  void initState() {
    super.initState();
    _getCityData();
  }

  Future<void> _getCityData() async {
    // Use the CityService object to get city data for the current city name
    cityData = await cityService.getCityData(cityName);
    // Trigger a UI update
    setState(() {});
  }
@override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${cityData?.fullName}',
            //'Mumbai',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: widget.data.length,
              itemBuilder: (context, index) {
                final statistics = widget.data[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          '${statistics.factor}: ',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: statistics.rating / 10,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '${statistics.rating}/10',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'City Rating: ',
                style: TextStyle(fontSize: 18),
              ),
              Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              Text(
                '4.5',
                //'${widget.data.map((e) => e.rating).reduce((a, b) => a + b) / widget.data.length}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RatingWidget()),
              )
            },
            child: const Text('Rate this city'),
          ),
        ],
      ),
    );
  }
}


class FavoriteIcon extends StatefulWidget {
  final bool isFavorite; // Pass the favorite state as a prop

  FavoriteIcon({required this.isFavorite});

  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}


class _FavoriteIconState extends State<FavoriteIcon> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite; // Set the initial state from the prop
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        color: _isFavorite ? Colors.red : Colors.white,
      ),
      onPressed: () {
        setState(() {
          _isFavorite = !_isFavorite;
        });
      },
    );
  }
}


@override
  _NeighborhoodStatisticsPageState createState() =>
      _NeighborhoodStatisticsPageState();


int city_id=0;

class NeighborhoodStatisticsPage extends StatefulWidget {
  @override
  _NeighborhoodStatisticsPageState createState() =>
      _NeighborhoodStatisticsPageState();
}

class _NeighborhoodStatisticsPageState extends State<NeighborhoodStatisticsPage> {
  bool _isNeighborhoodFavorited = false; // Track the favorite state
  final CityService cityService = CityService();
  String cityName = 'Delhi';
  CityData? cityData;

  CategoryScore? transport;
  double a1 = 0;
  int d1=0;
  CategoryScore? edu;
  double a2 = 0;
  int d2=0;
  CategoryScore? health;
  double a3 = 0;
  int d3=0;
  CategoryScore? costofliving;
  double a4 = 0;
  int d4=0;
  CategoryScore? business;
  double a5 = 0;
  int d5=0;
  CategoryScore? housing;
  double a6 = 0;
  int d6=0;
  CategoryScore? safety;
  double a7 = 0;
  int d7=0;
  CategoryScore? internet;
  double a8 = 0;
  int d8=0;
  CategoryScore? pollution_cat;
  double a9 = 0;
  int d9=0;
  CategoryScore? crime;
  double a10 = 0;
  int d10=0;


  List<NeighborhoodStatistics> statistics = [];

  @override
  void initState() {
    super.initState();
    _getCityData();
  }

  Future<void> _getCityData() async {
    // Use the CityService object to get city data for the current city name
    cityData = await cityService.getCityData(cityName);
    // housingCategory = cityData?.categories.firstWhere((category) => category.name == 'Housing');
    // a1 = housingCategory?.score as double;
    // d1=a1.toInt();
    //city_id=$ as int;{cityData?.geonameId;};
    city_id = cityData?.geonameId ?? 0;
    // print("$city_id");
    
    transport = cityData?.categories.firstWhere((category) => category.name == 'Travel Connectivity');
    a1 = transport?.score as double;
    d1=a1.toInt();

    edu = cityData?.categories.firstWhere((category) => category.name == 'Education');
    a2 = edu?.score as double;
    d2=a2.toInt();

    health = cityData?.categories.firstWhere((category) => category.name == 'Healthcare');
    a3 = health?.score as double;
    d3=a3.toInt();

    costofliving = cityData?.categories.firstWhere((category) => category.name == 'Cost of Living');
    a4 = costofliving?.score as double;
    d4=a4.toInt();

    business = cityData?.categories.firstWhere((category) => category.name == 'Business Freedom');
    a5 = business?.score as double;
    d5=a5.toInt();

    housing = cityData?.categories.firstWhere((category) => category.name == 'Housing');
    a6 = housing?.score as double;
    d6=a6.toInt();

    safety = cityData?.categories.firstWhere((category) => category.name == 'Safety');
    a7 = safety?.score as double;
    d7=a7.toInt();

    internet = cityData?.categories.firstWhere((category) => category.name == 'Internet Access');
    a8 = internet?.score as double;
    d8=a8.toInt();

    pollution_cat = cityData?.categories.firstWhere((category) => category.name == 'Environmental Quality');
    a9 = pollution_cat?.score as double;
    d9=a9.toInt();

    crime = cityData?.categories.firstWhere((category) => category.name == 'Venture Capital');
    a10 = crime?.score as double;
    d10=a10.toInt();

    //Initialize the statistics list with the updated value of a1
    statistics = [
      NeighborhoodStatistics('Crime Rate', d10),
      NeighborhoodStatistics('Transportation', d1),
      NeighborhoodStatistics('Education', d2),
      NeighborhoodStatistics('Healthcare', d3),
      NeighborhoodStatistics('Cost of Living', d4),
      NeighborhoodStatistics('Business', d5),
      NeighborhoodStatistics('Housing', d6),
      NeighborhoodStatistics('Safety', d7),
      NeighborhoodStatistics('Internet', d8),
      NeighborhoodStatistics('Pollution', d9),
    ];
    

    // Trigger a UI update
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City Details'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditFactorsScreen(),
                      ),
                    );
                  },
                ),
                FavoriteIcon(
                  isFavorite: _isNeighborhoodFavorited, // Pass the favorite state as a prop
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0),
            Image.network(
              '${cityData?.mobileImageLink}',
              //Uri.parse('${cityData?.mobileImageLink}') as String,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          
          Expanded(child: NeighborhoodStatisticsChart(data: statistics)),
        ],
      ),
    );
  }
}



//***********edit****************
class EditFactorsScreen extends StatefulWidget {
  // final int data;
  // EditFactorsScreen({required this.data});
  @override
  _EditFactorsScreenState createState() => _EditFactorsScreenState();
}

class _EditFactorsScreenState extends State<EditFactorsScreen> {
  final _formKey = GlobalKey<FormState>();

  double _crimeRate = 0.0;
  double _transportationConnectivity = 0.0;
  double _education = 0.0;
  double _healthcare = 0.0;
  double _costOfLiving = 0.0;
  double _businessFreedom = 0.0;
  double _housing = 0.0;
  double _safety = 0.0;
  double _internetConnectivity = 0.0;
  double _pollutionRate = 0.0;

//Save changes in the Database
void _saveChanges() async {
  try {
    
    String temp=city_id.toString();
    
    // Get a reference to the document you want to update
    DocumentReference docRef = FirebaseFirestore.instance.collection('City').doc(temp);

    // Update the document
    await docRef.update({
      //'population': 10927777,
      // 'categories.3.score_out_of_10': '$_crimeRate',
      // 'categories.4.score_out_of_10': '$_transportationConnectivity',
      // 'categories.9.score_out_of_10': 1,
      // 'categories.8.score_out_of_10': '$_healthcare',
      // 'categories.1.score_out_of_10': '$_costOfLiving',
      // 'categories.6.score_out_of_10': '$_businessFreedom',
      // 'categories.0.score_out_of_10': '$_housing',
      // 'categories.7.score_out_of_10': '$_safety',
      // 'categories.13.score_out_of_10': '$_internetConnectivity',
      // 'categories.10.score_out_of_10': '$_pollutionRate',
      // 'categories.0': FieldValue.arrayUnion([
      //                 {
      //                   'name': 'Housing',
      //                   'color':#ffffff,
      //                   'score_out_of_10': 4,
      //                 }
      //               ])
    });

    print("yes3");

    print("Document updated successfully");
  } catch (e) {
    print("Error updating document: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(),
        child: Scaffold(
      appBar: AppBar(
        title: Text('Edit Factors'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildSlider(
                label: 'Crime Rate',
                value: _crimeRate,
                onChanged: (newValue) {
                  setState(() {
                    _crimeRate = newValue;
                  });
                },
              ),
              _buildSlider(
                label: 'Transportation Connectivity',
                value: _transportationConnectivity,
                onChanged: (newValue) {
                  setState(() {
                    _transportationConnectivity = newValue;
                  });
                },
              ),
              _buildSlider(
                label: 'Education',
                value: _education,
                onChanged: (newValue) {
                  setState(() {
                    _education = newValue;
                  });
                },
              ),
              _buildSlider(
                label: 'Healthcare',
                value: _healthcare,
                onChanged: (newValue) {
                  setState(() {
                    _healthcare = newValue;
                  });
                },
              ),
              _buildSlider(
                label: 'Cost of Living',
                value: _costOfLiving,
                onChanged: (newValue) {
                  setState(() {
                    _costOfLiving = newValue;
                  });
                },
              ),
              _buildSlider(
                label: 'Business Freedom',
                value: _businessFreedom,
                onChanged: (newValue) {
                  setState(() {
                    _businessFreedom = newValue;
                  });
                },
              ),
              _buildSlider(
                label: 'Housing',
                value: _housing,
                onChanged: (newValue) {
                  setState(() {
                    _housing = newValue;
                  });
                },
              ),
              _buildSlider(
                label: 'Safety',
                value: _safety,
                onChanged: (newValue) {
                  setState(() {
                    _safety = newValue;
                  });
                },
              ),
              _buildSlider(
                label: 'Internet Connectivity',
                value: _internetConnectivity,
                onChanged: (newValue) {
                  setState(() {
                    _internetConnectivity = newValue;
                  });
                },
              ),
              _buildSlider(
                label: 'Pollution Rate',
                value: _pollutionRate,
                onChanged: (newValue) {
                  setState(() {
                    _pollutionRate = newValue;
                  });
                },
              ),
              SizedBox(height: 16),
              Builder(
  builder: (BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print("No");
        _saveChanges(); //For change data in Database
        print("yes");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NeighborhoodStatisticsPage()),
        );
      },
      child: Text('Save Changes'),
    );
  },
)
            ],
          ),
        ),
      ),
      ),
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Slider(
          value: value,
          min: 0,
          max: 10,
          divisions: 10,
          onChanged: onChanged,
          label: value.round().toString(),
        ),
      ],
    );
  }
}


void main() {
  runApp(MaterialApp(home: NeighborhoodStatisticsPage()));
}
