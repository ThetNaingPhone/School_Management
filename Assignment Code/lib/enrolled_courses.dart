import 'package:assignment2/enrolled_course_detail.dart';
import 'package:flutter/material.dart';// Import the CourseDetailScreen file
import 'package:assignment2/database-controller/database-controller.dart';

class EnrolledCoursesScreen extends StatefulWidget {
  @override
  _EnrolledCoursesScreenState createState() => _EnrolledCoursesScreenState();
}

class _EnrolledCoursesScreenState extends State<EnrolledCoursesScreen> {
  final DatabaseController _databaseController = DatabaseController();
  List<Map<String, dynamic>> _enrolledCourses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEnrolledCourses();
  }

  Future<void> _fetchEnrolledCourses() async {
    try {
      List<Map<String, dynamic>> courses = await _databaseController.getEnrolledCourses();
      setState(() {
        _enrolledCourses = courses;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching courses: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Enrolled Courses', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _enrolledCourses.isEmpty
          ? Center(child: Text('No enrolled courses yet.'))
          : ListView.builder(
        itemCount: _enrolledCourses.length,
        itemBuilder: (context, index) {
          final course = _enrolledCourses[index];
          return Card(
            color: Colors.grey[200],
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: ListTile(
              title: Text(course['courseName'], style: TextStyle(fontSize: 18)),
              subtitle: Text('Enrolled at: ${course['enrolledAt']}'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
              onTap: () {
                // Navigate to the CourseDetailScreen and pass the courseName
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseDetailScreen(courseName: course['courseName']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
