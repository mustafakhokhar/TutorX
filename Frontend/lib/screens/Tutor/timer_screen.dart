import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tutorx/screens/Tutor/offers_screen.dart';
import 'package:tutorx/screens/Tutor/online_tutor_total_charge.dart';
import 'package:tutorx/utils/base_client.dart';

class TimerScreen extends StatefulWidget {
  final tuition_id;
  final subject;
  final topic;
  final rate;

  const TimerScreen(
      {required this.tuition_id,
      required this.subject,
      required this.topic,
      required this.rate});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late Timer _timer;
  int _secondsElapsed = 0;

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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tuition in Progress:',
              style: TextStyle(fontSize: size.width * 0.06),
            ),
            Text(
              timerText,
              style: TextStyle(
                fontSize: size.width * 0.16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.03),
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
                    builder: (context) => ChargePage(
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
                  borderRadius: BorderRadius.circular(size.width * 0.1),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.12,
                    vertical: size.width * 0.06),
                backgroundColor: Colors.blue,
              ),
              child: Text(
                'End Tuition',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.05,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
