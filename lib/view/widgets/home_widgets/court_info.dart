import 'package:badminton_court_booking_app/view/constants.dart';
import 'package:badminton_court_booking_app/view/widgets/home_widgets/card_info.dart';
import 'package:flutter/material.dart';

class CourtInfo extends StatelessWidget {
  const CourtInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'IIT Indore Badminton Court',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            desc,
            style: TextStyle(color: Colors.black54, wordSpacing: 1.5),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CardInfo(title: 'Courts', value: '6'),
              CardInfo(title: 'Open Untill', value: '22:00 PM'),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CardInfo(title: 'Shower Area', value: 'YES'),
              CardInfo(title: 'Parking', value: '5'),
            ],
          )
        ],
      ),
    );
  }
}
