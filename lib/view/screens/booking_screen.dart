import 'package:badminton_court_booking_app/view/constants.dart';
import 'package:badminton_court_booking_app/view/screens/home_screen.dart';
import 'package:badminton_court_booking_app/view/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:badminton_court_booking_app/model/slot.dart' as slotModel;

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String data = 'empty';
  String chosenHour = hour[0];
  String chosenMinute = minute[0];
  String chosenTimeOfDay = timeOfDay[0];
  String availability = 'Choose a slot';
  DateTime chosenDate = DateTime.now();
  bool canBook = false;
  int availableCourtNo = -1;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    // TODO: implement your code here
    var val = args.value;
    DateTime t = val;

    setState(() {
      chosenDate = t;
      availability = 'Choose a slot';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: SfDateRangePicker(
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.single,
                minDate: DateTime.now(),
                //maxDate: DateTime.now().add(Duration(days: 2)),
              ),
            ),
            Text('Choose Time:'),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buileHourDropDown(),
                buileMinuteDropDown(),
                builetimeOfDayDropDown()
              ],
            ),
            Text(availability),
            Spacer(),
            CustomButton(
                name: 'Check Availability',
                onpressed: () async {
                  int m = int.parse(chosenMinute);
                  if (chosenTimeOfDay == 'PM') {
                    m += 12;
                  }

                  DateTime d = DateTime(
                      chosenDate.year, chosenDate.month, chosenDate.day, m);
                  print(d);
                  checkSlot(d);
                }),
            CustomButton(
                name: 'Confirm Booking',
                onpressed: () async {
                  int m = int.parse(chosenMinute);
                  if (chosenTimeOfDay == 'PM') {
                    m += 12;
                  }

                  DateTime d = DateTime(
                      chosenDate.year, chosenDate.month, chosenDate.day, m);
                  bookSlot(d);
                  // if (await bookSlot(d)) {
                  //   var snackBar =
                  //       SnackBar(content: Text('Successfully Booked'));
                  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  //   Navigator.pop(context);
                  // } else {
                  // var snackBar = SnackBar(content: Text('Booking Failed'));
                  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // }
                }),
          ],
        ),
      ),
    );
  }

  Widget buileHourDropDown() {
    return DropdownButton(
        value: chosenHour,
        items: hour.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem(value: value, child: Text(value));
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            chosenHour = value!;
            availability = 'Choose a slot';
          });
        });
  }

  Widget buileMinuteDropDown() {
    return DropdownButton(
        value: chosenMinute,
        items: minute.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem(value: value, child: Text(value));
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            chosenMinute = value!;
            availability = 'Choose a slot';
          });
        });
  }

  Widget builetimeOfDayDropDown() {
    return DropdownButton(
        value: chosenTimeOfDay,
        items: timeOfDay.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem(value: value, child: Text(value));
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            chosenTimeOfDay = value!;
            availability = 'Choose a slot';
          });
        });
  }

  Future checkSlot(DateTime d) async {
    List<int> courtsBooked = [];
    DateTime now = DateTime.now();
    if (d.millisecondsSinceEpoch < now.millisecondsSinceEpoch) {
      setState(() {
        canBook = false;
        availability = 'Not available';
      });
      return;
    }
    await FirebaseFirestore.instance
        .collection('slots')
        .where('dateTime', isEqualTo: d.millisecondsSinceEpoch)
        .get()
        .then((value) {
      for (var doc in value.docs) {
        slotModel.Slot _slot = slotModel.Slot.fromJson(doc);
        courtsBooked.add(_slot.courtNo);
      }
      if (courtsBooked.length == 6) {
        setState(() {
          canBook = false;
          availability = 'Not available';
        });
      } else {
        setState(() {
          canBook = true;
          availableCourtNo = courtsBooked.length + 1;
          availability = 'Available';
        });
      }
    });
  }

  Future bookSlot(DateTime dateTime) async {
    checkSlot(dateTime);
    if (!canBook) return;

    slotModel.Slot newSlot = slotModel.Slot(
        uid: FirebaseAuth.instance.currentUser!.uid,
        isCancelled: false,
        dateTime: dateTime.millisecondsSinceEpoch,
        courtNo: availableCourtNo);
    FirebaseFirestore.instance
        .collection('slots')
        .add(newSlot.toJson())
        .then((value) {
      var snackBar = SnackBar(content: Text('Booked Successfully'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      var snackBar = SnackBar(content: Text('Booking Failed'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
