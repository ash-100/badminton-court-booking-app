import 'package:badminton_court_booking_app/controller/auth_controller.dart';
import 'package:badminton_court_booking_app/view/screens/home_screen.dart';
import 'package:badminton_court_booking_app/view/screens/user_details_screen.dart';
import 'package:badminton_court_booking_app/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                    var credential = signInWithGoogle();
                    if (credential == null) {
                      var snackBar = SnackBar(
                          content:
                              Text('Error while loggin in. Please Try again'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      if (await checkIfUserExists()) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (route) => false);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserDetailsScreen()));
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
