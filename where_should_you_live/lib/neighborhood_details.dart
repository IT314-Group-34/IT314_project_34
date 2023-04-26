import 'package:flutter/material.dart';
import 'city_rating.dart';
import 'models/neibhorhood_model.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';

String cityName = 'mumbai';

class RatingWidget extends StatefulWidget {
  final CityService cityService = CityService();
  final CityDatabase citydatabase = CityDatabase();
  CityData? cityData;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference<Map<String, dynamic>> citiesCollection =
      FirebaseFirestore.instance.collection('City');

  @override
  _RatingWidgetState createState() => _RatingWidgetState(cityData, citiesCollection, citydatabase);

  @override
  void initState() {
    _getCityData();
  }

  Future<void> _getCityData() async {
    cityData = await cityService.getCityData(cityName);
    setState(() {});
  }

  void setState(Null Function() param0) {}
}

class _RatingWidgetState extends State<RatingWidget> {
  CityData? cityData;
  CollectionReference<Map<String, dynamic>> citiesCollection;
  CityDatabase citydatabase;
  int _rating = 0;
  int sum = 0;
  int count = 0;

  _RatingWidgetState(this.cityData, this.citiesCollection, this.citydatabase);

  //get citydatabase => null;

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
              onPressed: () async {
                // cityData?.rating += _rating;
                // cityData?.numberOfUsers += 1;
                // await cityService.updateCityData(cityData!); 
                await citydatabase.updateSumAndCount(cityName, _rating,1);
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
  //String cityName = 'mumbai';
  CityData? cityData;
  double ratings=0;
  int total_points=0;
  int total_users=0;

  @override
  void initState() {
    super.initState();
    _getCityData();
  }

  Future<void> _getCityData() async {
    // Use the CityService object to get city data for the current city name
    cityData = await cityService.getCityData(cityName);
    total_points=cityData!.rating;
    total_users=cityData!.numberOfUsers;
    ratings = total_points.toDouble() / total_users;
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
                ratings.toStringAsFixed(2),
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
//}


//  CategoryScore housingCategory = cityData.categories.firstWhere((category) => category.name == 'Housing');
@override
  _NeighborhoodStatisticsPageState createState() =>
      _NeighborhoodStatisticsPageState();

  //void setState(Null Function() param0) {}

int city_id=0;

class NeighborhoodStatisticsPage extends StatefulWidget {
  @override
  _NeighborhoodStatisticsPageState createState() =>
      _NeighborhoodStatisticsPageState();
}

class _NeighborhoodStatisticsPageState extends State<NeighborhoodStatisticsPage> {
  bool _isNeighborhoodFavorited = false; // Track the favorite state
  final CityService cityService = CityService();
  //String cityName = 'mumbai';
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
    //city_id=$ as int;{cityData?.geonameId;};
    city_id = cityData?.geonameId ?? 0;
    //url=Uri.parse('${cityData?.mobileImageLink}');
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
          // Container(
          //     height: 200,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(10),
          //       image: const DecorationImage(
          //         fit: BoxFit.cover,
          //         image: NetworkImage(
          //             'https://d13k13wj6adfdf.cloudfront.net/urban_areas/delhi-c0a7e4cf62.jpg'),
          //       ),
          //     ),
          //     ),
          

          
          // SizedBox(
          //   height: 200.0,
          //   width: 600.0,
          //   child: Image.network(
          //   //'${cityData?.mobileImageLink}',
          //   'https://d13k13wj6adfdf.cloudfront.net/urban_areas/delhi-c0a7e4cf62.jpg',
          //   fit: BoxFit.cover,
          // ),
          // ),
          
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
  final CityService cityService = CityService();
  // String cityName = 'mumbai';
  CityData? cityData;
  CategoryScore? crime;
  double val=0.0;

  @override
  void initState() {
    super.initState();
    _getCityData();
  }

  Future<void> _getCityData() async {
    // Use the CityService object to get city data for the current city name
    cityData = await cityService.getCityData(cityName);
    // crime = cityData?.categories.firstWhere((category) => category.name == 'Venture Capital');
    // val=cityData!.categories[1].score;
    // print("you are stuck with ${cityData!.categories[1].score}");
    // print("you also stuck with $val");
    // print("you also stuck with ${crime!.score}");
    // Trigger a UI update
    setState(() {});
  }

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
                     cityData!.categories[3].score = newValue;
                  });
                },
              ),
              _buildSlider(
                label: 'Transportation Connectivity',
                value: _transportationConnectivity,
                onChanged: (newValue) {
                  setState(() {
                    _transportationConnectivity = newValue;
                     cityData!.categories[4].score = newValue;
                  });
                },
              ),
              _buildSlider(
                label: 'Education',
                value: _education,
                onChanged: (newValue) {
                  setState(() {
                    _education = newValue;
                     cityData!.categories[9].score = newValue;
                  });
                },
              ),
              _buildSlider(
                label: 'Healthcare',
                value: _healthcare,
                onChanged: (newValue) {
                  setState(() {
                    _healthcare = newValue;
                     cityData!.categories[8].score = newValue;
                  });
                },
              ),
              _buildSlider(
                label: 'Cost of Living',
                value: _costOfLiving,
                onChanged: (newValue) {
                  setState(() {
                    _costOfLiving = newValue;
                     cityData!.categories[1].score = newValue;
                  });
                },
              ),
              _buildSlider(
                label: 'Business Freedom',
                value: _businessFreedom,
                onChanged: (newValue) {
                  setState(() {
                    _businessFreedom = newValue;
                     cityData!.categories[6].score = newValue;
                  });
                },
              ),
              _buildSlider(
                label: 'Housing',
                value: _housing,
                onChanged: (newValue) {
                  setState(() {
                    _housing = newValue;
                     cityData!.categories[0].score = newValue;
                  });
                },
              ),
              _buildSlider(
                label: 'Safety',
                value: _safety,
                onChanged: (newValue) {
                  setState(() {
                    _safety = newValue;
                     cityData!.categories[7].score = newValue;
                  });
                },
              ),
              _buildSlider(
                label: 'Internet Connectivity',
                value: _internetConnectivity,
                onChanged: (newValue) {
                  setState(() {
                    _internetConnectivity = newValue;
                     cityData!.categories[13].score = newValue;
                  });
                },
              ),
              _buildSlider(
                label: 'Pollution Rate',
                value: _pollutionRate,
                onChanged: (newValue) {
                  setState(() {
                    _pollutionRate = newValue;
                     cityData!.categories[10].score = newValue;
                  });
                },
              ),
              SizedBox(height: 16),
              Builder(
  builder: (BuildContext context) {
    return ElevatedButton(
      onPressed: () async{

    // Use the CityService object to update city data for the current city name
     await cityService.updateCityData(cityData!); 
      
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => NeighborhoodStatisticsPage()),
        // );
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
