import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API {
  static const baseUrl = "http://10.130.9.65/api/student/";

  static addStudentDetails(Map sdata) async {
    print(sdata);
    var url = Uri.parse("${baseUrl}add_student_details");
    try {
      final res = await http.post(url, body: sdata);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
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
