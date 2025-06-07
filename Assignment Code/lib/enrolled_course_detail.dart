import 'package:flutter/material.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseName; // Declare the courseName variable

  CourseDetailScreen({required this.courseName}); // Receive the courseName in the constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Course Detail'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the course name
            Text(
              courseName,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Course Progress:', style: TextStyle(fontSize: 16, color: Colors.black54)),
                Spacer(),
                Text('Complete 12 of 120', style: TextStyle(fontSize: 16, color: Colors.black54)),
              ],
            ),
            SizedBox(height: 5),
            LinearProgressIndicator(
              value: 0.10,
              color: Colors.deepPurple,
              backgroundColor: Colors.grey[100],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildSectionTitle("Syllabus"),
                  _buildContentText("• Module 1: Introduction to Networking\n• Module 2: Network Topologies\n• Module 3: Protocols Overview\n• Module 4: Advanced Topics"),

                  SizedBox(height: 20),

                  _buildSectionTitle("Schedule"),
                  _buildContentText("• Week 1: Introduction and Overview\n• Week 2: Network Topologies\n• Week 3: Protocols\n• Week 4: Final Assessment"),

                  SizedBox(height: 20),

                  _buildSectionTitle("Instructor Information"),
                  _buildContentText("• Name: John Doe\n• Email: john.doe@example.com\n• Office Hours: Mon-Fri, 9 AM - 11 AM"),

                  SizedBox(height: 30),

                  _buildModuleCard("Welcome aboard"),
                  _buildModuleCard("Introduction"),
                  _buildModuleCard("What is Network?"),
                  _buildModuleCard("Network Topologies"),
                  _buildModuleCard("Protocols Overview"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build the module cards
  Widget _buildModuleCard(String moduleTitle) {
    return Card(
      color: Colors.grey[100],
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(moduleTitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
        onTap: () {
          // You can add logic for navigating to a detailed module view
        },
      ),
    );
  }

  // Helper method to build section titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }

  // Helper method to build content text
  Widget _buildContentText(String content) {
    return Text(
      content,
      style: TextStyle(fontSize: 16, color: Colors.black54),
    );
  }
}
