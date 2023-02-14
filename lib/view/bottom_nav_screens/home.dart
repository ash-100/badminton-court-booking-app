import 'package:badminton_court_booking_app/model/user.dart' as userModel;
import 'package:badminton_court_booking_app/view/screens/booking_screen.dart';
import 'package:badminton_court_booking_app/view/widgets/custom_button.dart';
import 'package:badminton_court_booking_app/view/widgets/home_widgets/court_info.dart';
import 'package:badminton_court_booking_app/view/widgets/home_widgets/home_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  userModel.User user =
      userModel.User(name: '', uid: '', hostelName: '', roomNo: '');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    userModel.User _user = userModel.User.fromJson(userDoc);
    setState(() {
      user = _user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        HomeHeader(name: user.name),
        CourtInfo(),
        CustomButton(
            name: 'Book Court',
            onpressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BookingScreen()));
            })
      ],
    );
  }
}
