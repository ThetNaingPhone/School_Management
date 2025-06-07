import 'package:assignment2/home_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:assignment2/enrolled_courses.dart'; // Enrolled courses screen
import 'package:assignment2/profile.dart'; // Profile screen
import 'package:assignment2/progress_track.dart'; // Progress tracking screen
import 'course_detail_screen.dart'; // Assuming you have a course detail screen
import './constant/constant.dart'; // Import constants
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore dependency

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Track the selected bottom navigation bar index
  int _selectedIndex = 0;

  // Define the list of screens for the bottom navigation bar
  final List<Widget> _screens = [
    HomeScreenBody(),
    ProgressTrackScreen(),
    ProfileScreen(),
    EnrolledCoursesScreen(),
  ];

  // This method is called when a bottom navigation item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensure fixed bottom navigation
        selectedItemColor: Colors.blueAccent, // Color for selected item
        unselectedItemColor: Colors.grey, // Color for unselected items
        showUnselectedLabels: false, // Hide labels for unselected items
        currentIndex: _selectedIndex, // Track the selected item
        backgroundColor: Colors.white,
        onTap: _onItemTapped, // Handle navigation taps
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Courses',
          ),
        ],
      ),
    );
  }
}
