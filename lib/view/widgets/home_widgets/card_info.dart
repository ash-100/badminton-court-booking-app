import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({super.key, required this.title, required this.value});
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width / 2.5,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ],
      ),
    );
  }
}
