import 'package:cloud_firestore/cloud_firestore.dart';

class Slot {
  String id;
  String uid;
  bool isCancelled;
  int dateTime;
  int courtNo;

  Slot({
    required this.id,
    required this.uid,
    required this.isCancelled,
    required this.dateTime,
    required this.courtNo,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'isCancelled': isCancelled,
        'dateTime': dateTime,
        'courtNo': courtNo
      };

  static Slot fromJson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Slot(
        id: snapshot['id'],
        uid: snapshot['uid'],
        isCancelled: snapshot['isCancelled'],
        dateTime: snapshot['dateTime'],
        courtNo: snapshot['courtNo']);
  }
}
