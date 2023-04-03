// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  Users({
    required this.uid,
    required this.fullname,
    required this.student,
  });

  String uid;
  String fullname;
  bool student;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        uid: json["uid"],
        fullname: json["fullname"],
        student: json["student"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "fullname": fullname,
        "student": student,
      };
}
