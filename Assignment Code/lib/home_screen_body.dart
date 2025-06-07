import 'package:assignment2/database-controller/database-controller.dart';
import 'package:assignment2/enrolled_course_detail.dart';
import 'package:flutter/material.dart'; // Assuming you have a CourseDetailScreen
import './constant/constant.dart';

class HomeScreenBody extends StatelessWidget {
  final DatabaseController _databaseController = DatabaseController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with title and notification icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Discover Your Course",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications_none, color: Colors.black),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Search bar
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 30),

                // Popular Courses title
                Text(
                  "Courses",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 15),

                // Horizontal scroll for course cards
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      courseCard("Network", Colors.blueAccent, context, _databaseController),
                      courseCard("Flutter", Colors.pinkAccent, context, _databaseController),
                      courseCard("Business", Colors.greenAccent, context, _databaseController),
                      courseCard("DevOps", Colors.orangeAccent, context, _databaseController),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                // Assignments title
                Text(
                  "Assignments",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),

                // Dynamic assignment cards from constants
                ...assignments.map((assignment) {
                  return assignmentCard(
                    assignment['title']!,
                    assignment['deadline']!,
                  );
                }).toList(),

                SizedBox(height: 30),

                // Upcoming Classes title
                Text(
                  "Upcoming Classes",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),

                // Dynamic upcoming classes cards from constants
                ...upcomingClasses.map((upcomingClass) {
                  return upcomingClassCard(
                    upcomingClass['class']!,
                    Color(upcomingClass['color']),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }


  // Method to build a course card widget
  Widget courseCard(String title, Color color, BuildContext context, DatabaseController databaseController) {
    return GestureDetector(
      onTap: () {
        // Navigate to Course Detail Screen based on course name
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailScreen(courseName: title),
          ),
        );
      },
      child: Container(
        width: 150,
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center, // Align text in the center
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseDetailScreen(courseName: title),
                  ),
                );
              },
              child: Text("View Detail"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Button background color
                foregroundColor: color, // Button text color matches the card
                shape: StadiumBorder(), // Rounded button shape
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to create assignment card widget
  Widget assignmentCard(String title, String date) {
    return Card(
      color: Colors.grey[200],
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("Due: $date"),
          trailing: ElevatedButton(
            onPressed: () {},
            child: Text("Submit"),
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
          ),
        ),
      ),
    );
  }

  // Method to create upcoming class card widget
  Widget upcomingClassCard(String title, Color color) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        tileColor: color,
        textColor: Colors.white,
      ),
    );
  }
}
