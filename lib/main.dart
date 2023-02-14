import 'package:badminton_court_booking_app/firebase_options.dart';
import 'package:badminton_court_booking_app/view/screens/home_screen.dart';
import 'package:badminton_court_booking_app/view/screens/login_screen.dart';
import 'package:badminton_court_booking_app/view/screens/splash_screen.dart';
import 'package:badminton_court_booking_app/view/screens/user_details_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
