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
    // print('This is TUITON TIDD');
    // print(widget.tuition_id);
    while (!check) {
      final response =
          await BaseClient().get("/confirmedTuitions/${widget.tuition_id}").catchError((err) {});
      print('This is TUITON TIDD');
      print(widget.tuition_id);
      // print('Reponsee');
      // print(response);
      //Idrees Mapping not working
      var res = json.decode(response);
      print(res['message']);
      
      if (res['message'] == null){
        print("FOUND");
          check = true;
          break;
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
            
          ],
        ),
      ),
    );
  }
}
