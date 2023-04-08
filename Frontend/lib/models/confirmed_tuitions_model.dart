// To parse this JSON data, do
//
//     final confirmedTuitions = confirmedTuitionsFromJson(jsonString);

import 'dart:convert';

ConfirmedTuitions confirmedTuitionsFromJson(String str) =>
    ConfirmedTuitions.fromJson(json.decode(str));

String confirmedTuitionsToJson(ConfirmedTuitions data) =>
    json.encode(data.toJson());

class ConfirmedTuitions {
  ConfirmedTuitions({
    required this.id,
    this.tutorId,
    this.studentId,
    this.duration,
    this.amount,
  });

  String id;
  String? tutorId;
  String? studentId;
  double? duration;
  double? amount;

  factory ConfirmedTuitions.fromJson(Map<String, dynamic> json) =>
      ConfirmedTuitions(
        id: json["_id"],
        tutorId: json["tutor_id"],
        studentId: json["student_id"],
        duration: json["duration"]?.toDouble(),
        amount: json["amount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
      };
}
