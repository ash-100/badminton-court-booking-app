import 'package:badminton_court_booking_app/model/slot.dart' as slotModel;
import 'package:cloud_firestore/cloud_firestore.dart';

Future<int> checkSlot(DateTime d) async {
  List<int> courtsBooked = [];
  await FirebaseFirestore.instance
      .collection('slots')
      .where('dateTime', isEqualTo: d)
      .get()
      .then((value) {
    for (var doc in value.docs) {
      slotModel.Slot _slot = slotModel.Slot.fromJson(doc);
      courtsBooked.add(_slot.courtNo);
    }
    if (courtsBooked.length == 6) {
      return -1;
    } else {
      return courtsBooked.length + 1;
    }
  });
  return -1;
}

Future<bool> bookSlot(DateTime dateTime) async {
  int courtNo = await checkSlot(dateTime);
  if (courtNo == -1) {
    return false;
  }
  slotModel.Slot newSlot =
      slotModel.Slot(isCancelled: false, dateTime: dateTime, courtNo: courtNo);
  FirebaseFirestore.instance
      .collection('slots')
      .add(newSlot.toJson())
      .then((value) {
    return true;
  });
  return false;
}
