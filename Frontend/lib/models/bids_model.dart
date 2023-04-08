// To parse this JSON data, do
//
//     final bids = bidsFromJson(jsonString);

import 'dart:convert';

Bids bidsFromJson(String str) => Bids.fromJson(json.decode(str));

String bidsToJson(Bids data) => json.encode(data.toJson());

class Bids {
  Bids({
    this.studentId,
    this.tutorId,
    this.tutorName,
    this.bidAmount,
  });

  String? studentId;
  String? tutorId;
  String? tutorName;
  int? bidAmount;

  factory Bids.fromJson(Map<String, dynamic> json) => Bids(
        studentId: json["student_id"],
        tutorId: json["tutor_id"],
        tutorName: json["tutor_name"],
        bidAmount: json["bid_amount"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "tutor_id": tutorId,
        "tutor_name": tutorName,
        "bid_amount": bidAmount,
      };
}
