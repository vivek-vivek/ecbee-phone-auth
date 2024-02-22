import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pnone_auth/modules/Dashboard/data/models/user_model.dart';
import 'package:pnone_auth/modules/login/data/models/login_model.dart';
import 'package:pnone_auth/modules/users/data/models/users_model.dart';
import 'package:pnone_auth/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'modules/login/data/datasources/firebase/firestore_helper.dart';
import 'modules/login/presentation/screens/login_screen.dart';
import 'modules/users/presentation/screens/users_screen.dart';

final messangerKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
  log("message");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: Constants.firebaseKey,
        appId: Constants.firebaseAppID,
        messagingSenderId: "Vivek",
        projectId: Constants.fireBaseProjectID),
  );

  // Both of the following lines are good for testing,
  // but can be removed for release builds
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      scaffoldMessengerKey: messangerKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
