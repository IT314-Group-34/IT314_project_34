import 'package:flutter/material.dart';
import './edit.dart';

class NeighborhoodStatistics {
  final String factor;
  final int rating;

  NeighborhoodStatistics(this.factor, this.rating);
}

class NeighborhoodStatisticsChart extends StatelessWidget {
  final List<NeighborhoodStatistics> data;

  NeighborhoodStatisticsChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Neighborhood Name',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final statistics = data[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 120, child: Text('${statistics.factor}: ', style: TextStyle(fontSize: 14))),
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
          ElevatedButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditPage()),
              )
            },
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }
}

class NeighborhoodStatisticsPage extends StatelessWidget {
  final List<NeighborhoodStatistics> statistics = [
    NeighborhoodStatistics('Crime Rate', 8),
    NeighborhoodStatistics('Transportation', 9),
    NeighborhoodStatistics('Education', 7),
    NeighborhoodStatistics('Healthcare', 9),
    NeighborhoodStatistics('Cost of Living', 6),
    NeighborhoodStatistics('Business', 8),
    NeighborhoodStatistics('Housing', 7),
    NeighborhoodStatistics('Safety', 9),
    NeighborhoodStatistics('Internet', 8),
    NeighborhoodStatistics('Pollution', 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Neighborhood Statistics')),
      body: Column(
        children: [
          Container(
            height: 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://www.pexels.com/search/flower%20garden/',scale:1),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(child: NeighborhoodStatisticsChart(data: statistics)),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: NeighborhoodStatisticsPage()));
}

