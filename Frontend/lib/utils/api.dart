import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API {
  // change ip address to
  // static const ipAddress = "http://10.130.9.65";
  static const ipAddress = "http://10.0.2.2:2000";
  static const baseUrl = "$ipAddress/api/student/";

  static addStudentDetails(Map sdata) async {
    print("API DATA RECEIVED $sdata");
    var url = Uri.parse("${baseUrl}add_student_details");
    try {
      final res = await http.post(url, body: sdata);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print("RESPONSE FROM BACKEND $data");
        //
      } else {
        print("Failed to get Data");
        //
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
