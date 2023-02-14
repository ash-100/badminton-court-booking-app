import 'package:badminton_court_booking_app/view/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {super.key,
      required this.name,
      required this.onpressed,
      this.color = Colors.green});
  final String name;
  final GestureTapCallback onpressed;
  final Color color;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: widget.color,
              padding: EdgeInsets.all(16),
              minimumSize: Size(MediaQuery.of(context).size.width, 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40))),
          child: Text(widget.name),
          onPressed: widget.onpressed),
    );
  }
}
