import 'package:assignment2/enrolled_courses.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:assignment2/database-controller/database-controller.dart';
import 'login_screen.dart'; // Import Enrolled Courses Screen

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final DatabaseController _dbController = DatabaseController();

  bool _isLoading = true;
  bool _isEditing = false; // Track editing state

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final userData = await _dbController.getUserData(user.uid);
        if (userData != null) {
          _nameController.text = userData['name'] ?? 'Jack';
          _emailController.text = userData['email'] ?? 'jack@gmail.com';
          _phoneController.text = userData['phone'] ?? '';
        }
      } catch (e) {
        print("Error fetching user data: $e");
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _updateUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _dbController.updateUserData(
        user.uid,
        _nameController.text,
        _emailController.text,
        _phoneController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Profile', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25)),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing; // Toggle edit mode
              });
              if (!_isEditing) {
                _updateUserData(); // Update Firestore if done editing
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blueGrey[400],
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),

              // Editable Username Field
              _isEditing
                  ? _buildEditableField(Icons.person, _nameController)
                  : Text(
                _nameController.text,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[900],
                ),
              ),

              Center(
                child: Text(
                  "Student",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey[600],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Editable Email and Phone info
              _isEditing
                  ? _buildEditableField(Icons.email, _emailController)
                  : _buildMenuItem(Icons.email, _emailController.text, () {}),
              _isEditing
                  ? _buildEditableField(Icons.phone, _phoneController)
                  : _buildMenuItem(Icons.phone, _phoneController.text, () {}),

              SizedBox(height: 20),

              // Menu Items (Aligned)
              _buildMenuItem(Icons.favorite, "Your Favorites", () {}),
              _buildMenuItem(Icons.book, "Enrolled Courses", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EnrolledCoursesScreen()),
                );
              }),
              _buildMenuItem(Icons.event, "Events", () {}),
              _buildMenuItem(Icons.settings, "Settings", () {}),

              SizedBox(height: 20),

              // Logout link (aligned with phone and email)
              Container(
                margin: EdgeInsets.only(left: 20.0), // Set left margin
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.redAccent), // Logout Icon
                      SizedBox(width: 10), // Space between icon and text
                      GestureDetector(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text(
                          'Log out',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16,
                            decoration: TextDecoration.none, // No underline
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build menu item
  Widget _buildMenuItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey[700]),
      title: Text(label, style: TextStyle(color: Colors.blueGrey[800])),
      // trailing: Icon(Icons.arrow_forward_ios,
      //     size: 16, color: Colors.blueGrey[400]),
      onTap: onTap,
    );
  }

  // Helper method to build editable field
  Widget _buildEditableField(IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          // Icon(icon, color: Colors.blueGrey[700]),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter ${icon == Icons.email ? 'email' : icon == Icons.phone ? 'phone number' : 'username'}',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

