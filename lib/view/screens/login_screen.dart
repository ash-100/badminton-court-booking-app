import 'package:badminton_court_booking_app/controller/auth_controller.dart';
import 'package:badminton_court_booking_app/view/screens/home_screen.dart';
import 'package:badminton_court_booking_app/view/screens/user_details_screen.dart';
import 'package:badminton_court_booking_app/view/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool userExists = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Book A Badminton Court',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 50),
                    child: Text(
                      'Challenge your friend and play together a game of badminton',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                child: Image.asset('assets/images/intro_image.jpg'),
              ),
              CustomButton(
                  name: 'Login',
                  onpressed: () async {
                    final GoogleSignInAccount? googleUser =
                        await GoogleSignIn().signIn();
                    final GoogleSignInAuthentication? googleAuth =
                        await googleUser?.authentication;

                    final credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth?.accessToken,
                        idToken: googleAuth?.idToken);
                    UserCredential _userCredential = await FirebaseAuth.instance
                        .signInWithCredential(credential);

                    if (_userCredential == null) {
                      var snackBar = SnackBar(
                          content:
                              Text('Error while loggin in. Please Try again'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get()
                          .then((value) {
                        if (value.exists &&
                            value.data()!['name'].toString().trim() != '') {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserDetailsScreen()));
                        }
                      });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
