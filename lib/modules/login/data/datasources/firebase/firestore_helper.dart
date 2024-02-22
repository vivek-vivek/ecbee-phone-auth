import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pnone_auth/modules/login/data/models/login_model.dart';

class FirebaseDatabaseHelper {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  addLoginInformation(LoginModel loginModel) async {
    final doc =
        firestore.collection('login_info').doc(); // Create a new Document
    loginModel.id = doc.id; // Add the document ID to the model
    await doc.set(loginModel.toJson()); // Save the model to the database
  }
}
