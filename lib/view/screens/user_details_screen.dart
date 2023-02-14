import 'package:badminton_court_booking_app/model/user.dart' as userModel;
import 'package:badminton_court_booking_app/view/screens/home_screen.dart';
import 'package:badminton_court_booking_app/view/widgets/custom_button.dart';
import 'package:badminton_court_booking_app/view/widgets/custom_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController hostelController = TextEditingController();
  TextEditingController roomNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.centerLeft,
                color: Colors.green,
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Enter User Details',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            CustomInput(
              name: 'Name',
              hint: 'Enter name',
              controller: nameController,
            ),
            CustomInput(
              name: 'Hostel',
              hint: 'Enter hostel name',
              controller: hostelController,
            ),
            CustomInput(
              name: 'Room Number',
              hint: 'Enter room number',
              controller: roomNoController,
            ),
            SizedBox(
              height: 32,
            ),
            CustomButton(
                name: 'Continue',
                onpressed: () async {
                  try {
                    userModel.User newUser = userModel.User(
                        name: nameController.text.trim(),
                        uid: FirebaseAuth.instance.currentUser!.uid,
                        hostelName: hostelController.text.trim(),
                        roomNo: roomNoController.text.trim());
                    var userCol =
                        FirebaseFirestore.instance.collection('users');
                    await userCol
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .set(newUser.toJson());
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false);
                  } catch (e) {
                    var snackBar =
                        SnackBar(content: Text('Error while adding info'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();
    path.lineTo(0, h);
    path.quadraticBezierTo(w * 0.5, h - 100, w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
