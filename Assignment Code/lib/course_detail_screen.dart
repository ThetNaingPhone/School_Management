import 'package:flutter/material.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseName;

  // Constructor
  CourseDetailScreen({required this.courseName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Welcome User', style: TextStyle(fontSize: 18)),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flutter',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Course Content',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  courseLessonCard("Let’s get started"),
                  courseLessonCard("Welcome aboard"),
                  courseLessonCard("Introduction"),
                  courseLessonCard("What is Flutter?"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget courseLessonCard(String lessonTitle) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(lessonTitle),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Optional navigation for lessons
        },
      ),
    );
  }
}