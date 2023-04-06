// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    this.id,
    required this.uid,
    required this.fullname,
    required this.student,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String uid;
  String fullname;
  bool student;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["_id"],
        uid: json["uid"],
        fullname: json["fullname"],
        student: json["student"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "fullname": fullname,
        "student": student,
      };
}
