import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // Fetch user data from Firestore
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot snapshot =
      await _firestore.collection('users').doc(userId).get();
      return snapshot.data() as Map<String, dynamic>?;
    } catch (e) {
      print("Failed to fetch user data: $e");
      return null;
    }
  }

  // Method to update user data in Firestore
  Future<void> updateUserData(
      String userId, String name, String email, String phone) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'name': name,
        'email': email,
        'phone': phone,
      });
      print("User data updated successfully.");
    } catch (e) {
      print("Failed to update user data: $e");
    }
  }
  // Method to enroll a user in a course
  Future<void> enrollInCourse(String courseName) async {
    try {
      await _firestore.collection('enrolled_courses').add({
        'courseName': courseName,
        'enrolledAt': Timestamp.now(),
      });
      print("Successfully enrolled in $courseName.");
    } catch (e) {
      print("Failed to enroll in course: $e");
    }
  }

  // Method to fetch enrolled courses from Firestore
  Future<List<Map<String, dynamic>>> getEnrolledCourses() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('enrolled_courses').get();
      List<Map<String, dynamic>> enrolledCourses = snapshot.docs.map((doc) {
        return {
          'courseName': doc['courseName'],
          'enrolledAt': (doc['enrolledAt'] as Timestamp).toDate(), // Convert to DateTime
        };
      }).toList();
      return enrolledCourses;
    } catch (e) {
      print("Failed to get enrolled courses: $e");
      return [];
    }
  }
}
