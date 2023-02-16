import 'dart:async';

import 'package:badminton_court_booking_app/view/constants.dart';
import 'package:badminton_court_booking_app/view/screens/home_screen.dart';
import 'package:badminton_court_booking_app/view/screens/login_screen.dart';
import 'package:badminton_court_booking_app/view/screens/user_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () async {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) {
          if (value.exists && value.data()!['name'].toString().trim() != '') {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => UserDetailsScreen()));
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0e8844),
      body: Container(
        child: Center(
          child: Text(
            'NetZone',
            style: TextStyle(
                color: Colors.white, fontSize: 50, fontStyle: FontStyle.italic),
          ),
        ),
      ),
    );
  }
}
