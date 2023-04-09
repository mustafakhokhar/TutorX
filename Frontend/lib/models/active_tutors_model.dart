// To parse this JSON data, do
//
//     final activeTutors = activeTutorsFromJson(jsonString);

import 'dart:convert';

ActiveTutors activeTutorsFromJson(String str) =>
    ActiveTutors.fromJson(json.decode(str));

String activeTutorsToJson(ActiveTutors data) => json.encode(data.toJson());

class ActiveTutors {
  ActiveTutors({
    required this.uid,
    required this.longitude,
    required this.latitude,
  });

  String uid;
  double longitude;
  double latitude;

  factory ActiveTutors.fromJson(Map<String, dynamic> json) => ActiveTutors(
        uid: json["uid"],
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "longitude": longitude,
        "latitude": latitude,
      };
}
