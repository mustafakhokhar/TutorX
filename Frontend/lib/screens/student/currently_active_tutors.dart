import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../utils/base_client.dart';

class CurrentlyActive extends StatefulWidget {
  const CurrentlyActive({super.key});

  @override
  State<CurrentlyActive> createState() => _CurrentlyActiveState();
}

class _CurrentlyActiveState extends State<CurrentlyActive> {
  Timer? _timer;
  var _prevResponse;

  void getCurrentActive() async {
    var response = await BaseClient().get("/activeTutors").catchError((err) {});
    var responseList = jsonDecode(response);
    if (_prevResponse == null) {
      // If this is the first response, set the previous response to the current response
      _prevResponse = responseList;
    } else {
      // Compare the new response with the previous response
      var newValues = responseList
          .where((value) => !_prevResponse.contains(value))
          .toList();
      // If there are new values, print them and update the previous response
      if (newValues.isNotEmpty) {
        print(newValues);
        _prevResponse = responseList;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Call the getCurrentActive method initially
    getCurrentActive();
    // Set up a timer to call getCurrentActive every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      getCurrentActive();
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
    );
  }
}
