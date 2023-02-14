import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String uid;
  String hostelName;
  String roomNo;

  User({
    required this.name,
    required this.uid,
    required this.hostelName,
    required this.roomNo,
  });

  Map<String, dynamic> toJson() =>
      {"name": name, "uid": uid, "hostelName": hostelName, "roomNo": roomNo};

  static User fromJson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        name: snapshot['name'],
        uid: snapshot['uid'],
        hostelName: snapshot['hostelName'],
        roomNo: snapshot['roomNo']);
  }
}
