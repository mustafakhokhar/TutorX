// To parse this JSON data, do
//
//     final devices = devicesFromJson(jsonString);

import 'dart:convert';

Devices devicesFromJson(String str) => Devices.fromJson(json.decode(str));

String devicesToJson(Devices data) => json.encode(data.toJson());

class Devices {
  Devices({
    required this.uid,
    required this.device,
  });

  String uid;
  String device;

  factory Devices.fromJson(Map<String, dynamic> json) => Devices(
        uid: json["uid"],
        device: json["device"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "device": device,
      };
}
