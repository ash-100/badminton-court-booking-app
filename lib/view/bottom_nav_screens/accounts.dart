import 'package:badminton_court_booking_app/view/screens/login_screen.dart';
import 'package:badminton_court_booking_app/view/widgets/custom_button.dart';
import 'package:badminton_court_booking_app/view/widgets/custom_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badminton_court_booking_app/model/user.dart' as userModel;

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  userModel.User user = userModel.User(
      name: 'Name', uid: '', hostelName: 'Hostel Name', roomNo: 'Room Number');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  void getUserData() async {
    userModel.User _user = userModel.User.fromJson(await FirebaseFirestore
        .instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get());
    setState(() {
      nameController.text = _user.name;
      hostelNameController.text = _user.hostelName;
      roomNoController.text = _user.roomNo;
      user = _user;
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController hostelNameController = TextEditingController();
  TextEditingController roomNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text(
              'Profile',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Image.network(
            FirebaseAuth.instance.currentUser!.photoURL ??
                'https://eu.ui-avatars.com/api/?name=A&size=250',
            fit: BoxFit.cover,
          ),
          CustomInput(
              name: 'Name',
              hint: 'Enter user name',
              controller: nameController),
          CustomInput(
              name: 'Hostel Name',
              hint: 'Enter hostel name',
              controller: hostelNameController),
          CustomInput(
              name: 'Room Number',
              hint: 'Enter room number',
              controller: roomNoController),
          SizedBox(
            height: 40,
          ),
          CustomButton(
              name: 'Save changes',
              onpressed: () async {
                user.name = nameController.text;
                user.hostelName = hostelNameController.text;
                user.roomNo = roomNoController.text;

                try {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update(user.toJson())
                      .then((value) {
                    var snackBar =
                        SnackBar(content: Text('Successfully Updated'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                } catch (e) {
                  var snackBar =
                      SnackBar(content: Text('Error while updating'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }),
          CustomButton(
              color: Colors.red,
              name: 'Logout',
              onpressed: () async {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              }),
        ],
      ),
    );
  }
}
