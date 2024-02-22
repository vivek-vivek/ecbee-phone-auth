import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pnone_auth/modules/Dashboard/data/models/user_model.dart';

class FirebaseDatabaseHelper {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  addLoginInformation(UserModel userModel) async {
    final doc =
        firestore.collection('login_info').doc(); // Create a new Document
    userModel.id = doc.id; // Add the document ID to the model
    await doc.set(userModel.toJson()); // Save the model to the database
  }

  // Function to get currently logged-in user information from Firestore
  Future<User?> getCurrentUserInformation() async {
    User? user = FirebaseAuth.instance.currentUser; // Get the current user
    if (user != null) {
      // If user is logged in
      String userId = user.uid; // Get the user's ID
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('login_info')
          .doc(userId)
          .get(); // Fetch the document corresponding to the user's ID
      if (userDoc.exists) {
        // If the document exists
        // Convert the document snapshot to a map and return it
        log(userDoc.data().toString(), name: "USER");
        return userDoc.data() as User?;
      }
    }
    return null; // Return null if no user is logged in or user document doesn't exist
  }
}
