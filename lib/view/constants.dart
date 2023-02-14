//Screens
import 'package:badminton_court_booking_app/view/bottom_nav_screens/home.dart';
import 'package:badminton_court_booking_app/view/bottom_nav_screens/slots.dart';
import 'package:flutter/material.dart';

List<Widget> pages = [
  Home(),
  MySlot(),
  Text('Account'),
];

//colors
Color primaryColor = Colors.green;

//content
String desc =
    'Even if you are a person with a low interest in sports, badminton is one sport that most people surely enjoy. With new badminton-courts being set up inside the campus, this is one sport that you have to play. Tournaments of singles and mixed-doubled are held on a regular basis. Badminton is also one of the most happening sports at IIT-I. The badminton-club will be delighted to make you a part of them.';
List<String> hour = [
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
];

List<String> minute = ['00', '30'];
List<String> timeOfDay = ['AM', 'PM'];
