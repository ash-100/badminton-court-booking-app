import 'package:flutter/material.dart';

class SingleFieldInfoSlot extends StatelessWidget {
  const SingleFieldInfoSlot(
      {super.key, required this.name, required this.value});
  final String name, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          Text(
            name + ' : ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
