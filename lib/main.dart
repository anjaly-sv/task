import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task/screens/description%20screen.dart';
import 'package:task/screens/homescreen.dart';
import 'package:task/screens/loginpage.dart';
import 'package:task/screens/signUp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyACjYffCBLPL3FckbaTWIXr1-h5qn6NVf8",
        appId: "1:23067925287:android:391259e9d0abeb4e2a2702",
        messagingSenderId: "23067925287",
        projectId: "sree-cart",));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "HomePage": (context) =>HomePage(),
        "DescriptionScreen" : (context)=> DescriptionScreen()
      },
      home: SignUp(),
    );
  }
}
