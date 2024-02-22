import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/users_model.dart';

class FirebaseDatabaseHelper {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  getLastLogin() {
    final collection =
        firestore.collection('login_info'); // Initiate the collection
    final List<UsersModel> logins = []; // Create the list
    collection.get().then((value) => {
          // Get the documents from the collection and convert the snapshots into a json and then convert it into the model
          value.docs.forEach((element) {
            log(element.data().toString(), name: "USERS");
            logins.add(UsersModel.fromJson(element.data()));
          })
        });
    return logins; // Returning the list
  }
}
