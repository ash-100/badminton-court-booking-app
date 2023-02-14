import 'package:badminton_court_booking_app/model/slot.dart' as slotModel;
import 'package:badminton_court_booking_app/view/widgets/slots_widgets/slot_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MySlot extends StatefulWidget {
  const MySlot({super.key});

  @override
  State<MySlot> createState() => _MySlotState();
}

class _MySlotState extends State<MySlot> {
  var stream = FirebaseFirestore.instance
      .collection('slots')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'My Bookings',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error while loading data'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text('No data to display'),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.size,
                itemBuilder: (context, index) {
                  slotModel.Slot _slot = slotModel.Slot.fromJson(
                      snapshot.data!.docs.elementAt(index));
                  return SlotInfo(
                    slot: _slot,
                  );
                });
          },
        ))
      ],
    );
  }
}
