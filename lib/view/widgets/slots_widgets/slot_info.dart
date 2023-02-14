import 'package:badminton_court_booking_app/model/slot.dart' as slotModel;
import 'package:badminton_court_booking_app/view/widgets/custom_button.dart';
import 'package:badminton_court_booking_app/view/widgets/slots_widgets/single_info_slot.dart';
import 'package:flutter/material.dart';

class SlotInfo extends StatefulWidget {
  const SlotInfo({
    super.key,
    required this.slot,
  });
  final slotModel.Slot slot;

  @override
  State<SlotInfo> createState() => _SlotInfoState();
}

class _SlotInfoState extends State<SlotInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleFieldInfoSlot(
            name: 'Date',
            value: DateTime.fromMillisecondsSinceEpoch(widget.slot.dateTime)
                .toString(),
          ),
          SingleFieldInfoSlot(
            name: 'Time',
            value: DateTime.fromMillisecondsSinceEpoch(widget.slot.dateTime)
                .toString(),
          ),
          SingleFieldInfoSlot(
              name: 'Court No', value: widget.slot.courtNo.toString()),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Spacer(),
              DateTime.now().millisecondsSinceEpoch > widget.slot.dateTime
                  ? Container(
                      padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Center(
                          child: Text(
                        'DONE',
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                    )
                  : widget.slot.isCancelled
                      ? Container(
                          padding: EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Center(
                              child: Text(
                            'CANCELLED',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: CustomButton(
                            name: 'Cancel',
                            onpressed: () {},
                            color: Colors.red,
                          ),
                        ),
              Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
