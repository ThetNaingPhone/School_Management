import 'package:flutter/material.dart';

class ProgressTrackScreen extends StatelessWidget {
  final List<Map<String, dynamic>> courses = [
    {'title': 'Networking', 'progress': 0.43},
    {'title': 'Flutter', 'progress': 0.20},
    {'title': 'Business Support', 'progress': 0.84},
    {'title': 'devops', 'progress': 0.10},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Progress Track', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey[200],
              child: ListTile(
                title: Text(courses[index]['title']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: courses[index]['progress'],
                      color: Colors.green,
                      backgroundColor: Colors.grey[300],
                    ),
                    SizedBox(height: 5),
                    Text('${(courses[index]['progress'] * 100).toInt()}%'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}