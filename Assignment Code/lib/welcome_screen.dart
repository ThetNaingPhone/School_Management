import 'package:assignment2/login_screen.dart';
import 'package:assignment2/signup_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Align elements to start
        children: [
          SizedBox(height: 150), // Move the entire content a little up
          const CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage('assets/images/school_logo.png'),
            backgroundColor: Colors.transparent,
            child: Icon(Icons.person, size: 80, color: Colors.white),
          ),
          SizedBox(height: 20),
          Text(
            'WELCOME',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40), // Space between Welcome and buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 18, // Larger font size
                    fontWeight: FontWeight.bold, // Bold text
                    color: Colors.black, // Black color
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  backgroundColor: Colors.white, // White background
                  side: BorderSide(color: Colors.black), // Black border
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 18, // Larger font size
                    fontWeight: FontWeight.bold, // Bold text
                    color: Colors.black, // Black color
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  backgroundColor: Colors.grey[400], // Gray background
                ),
              ),
            ],
          ),
          SizedBox(height: 30), // Adjust space after the buttons
        ],
      ),
    );
  }
}