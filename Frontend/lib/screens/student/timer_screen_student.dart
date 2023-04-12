import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tutorx/models/confirmed_tuitions_model.dart';
import 'package:tutorx/models/pending_tuitions_model.dart';
import 'package:tutorx/screens/Tutor/offers_screen.dart';
// import 'package:tutorx/screens/Student/online_student_total_charge.dart';
import 'package:tutorx/screens/student/online_student_total_charge.dart';
import 'package:tutorx/utils/base_client.dart';

import '../../utils/shared_preferences_utils.dart';

class TimerScreenStd extends StatefulWidget {
  final tuition_id;
  final subject;
  final topic;
  final rate;

  const TimerScreenStd(
      {required this.tuition_id,
      required this.subject,
      required this.topic,
      required this.rate});

  @override
  _TimerScreenStdState createState() => _TimerScreenStdState();
}

class _TimerScreenStdState extends State<TimerScreenStd> {
  late Timer _timer;
  int _secondsElapsed = 0;
  bool check = false;

  checkIfAccepted() async {
    print('This is TUITON TIDD');
    print(tuition_id);
    while (!check) {
      final response =
          await BaseClient().get("/confirmedTuitions").catchError((err) {});
      print('This is TUITON TIDD');
      print(tuition_id);
      print('Reponsee');
      print(response);
      //Idrees Mapping not working
      List<dynamic> res = json.decode(response);

      List<ConfirmedTuitions> confirmedtuitions =
          res.map((json) => ConfirmedTuitions.fromJson(json)).toList();
      print('PRINGITNG RESS');
      print(res);
      // final List<Offer> offers = [];

      for (var i = 0; i < res.length; i++) {
        var start = res[0]["_id"];
        print('THIS IS START');
        print(start);
        print(widget.rate);
        print(widget.tuition_id);
        var uid = await SharedPreferencesUtils.getUID();
        // print("UID : $uid");
        // print("TID :$start");
        if (start == tuition_id) {
          check = true;
          break;
        }
      }
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChargePageStd(
          tuition_id: widget.tuition_id,
          subject: widget.subject,
          topic: widget.topic,
          rate: widget.rate,
        ),
      ),
    );
    // Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  String get timerText {
    Duration duration = Duration(seconds: _secondsElapsed);
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    checkIfAccepted();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tuition in Progress:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              timerText,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // Code for starting the tuition
                var obj = {"tuition_id": tuition_id};
                var objJSON = jsonEncode(obj);
                final response = await BaseClient()
                    .post("/confirmedTuitions", objJSON)
                    .catchError((err) {});
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChargePageStd(
                      tuition_id: widget.tuition_id,
                      subject: widget.subject,
                      topic: widget.topic,
                      rate: widget.rate,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                backgroundColor:
                    Colors.blue, // Change this to the desired color
              ),
              child: Text(
                'End Tuition',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
