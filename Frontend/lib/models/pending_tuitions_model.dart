// To parse this JSON data, do
//
//     final pendingTuitions = pendingTuitionsFromJson(jsonString);

import 'dart:convert';

PendingTuitions pendingTuitionsFromJson(String str) =>
    PendingTuitions.fromJson(json.decode(str));

String pendingTuitionsToJson(PendingTuitions data) =>
    json.encode(data.toJson());

class PendingTuitions {
  PendingTuitions({
    required this.studentId,
    required this.topic,
    required this.subject,
    required this.longitude,
    required this.latitude,
    this.tutorBids,
  });

  String studentId;
  String topic;
  String subject;
  double longitude;
  double latitude;
  List<TutorBid>? tutorBids;

 factory PendingTuitions.fromJson(Map<String, dynamic> json) =>
      PendingTuitions(
        studentId: json["student_id"],
        topic: json["topic"],
        subject: json["subject"],
        longitude: (json["longitude"] is int)
            ? (json["longitude"] as int).toDouble()
            : json["longitude"],
        latitude: (json["latitude"] is int)
            ? (json["latitude"] as int).toDouble()
            : json["latitude"],
        tutorBids: json["tutor_bids"] != null
            ? List<TutorBid>.from(
                json["tutor_bids"].map((x) => TutorBid.fromJson(x)))
            : null,
      );


  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "topic": topic,
        "subject": subject,
        "longitude": longitude,
        "latitude": latitude,
      };
}

class TutorBid {
  TutorBid({
    required this.tutorId,
    required this.bidAmount,
    this.id,
  });

  String tutorId;
  int bidAmount;
  String? id;

  factory TutorBid.fromJson(Map<String, dynamic> json) => TutorBid(
        tutorId: json["tutor_id"],
        bidAmount: json["bid_amount"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() =>
      {"tutor_id": tutorId, "bid_amount": bidAmount};
}
