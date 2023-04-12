import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:tutorx/models/bids_model.dart';
import 'package:tutorx/models/pending_tuitions_model.dart';
import 'package:tutorx/models/user_model.dart';
import 'package:tutorx/screens/Tutor/bid.dart';
import 'package:tutorx/screens/Tutor/offers_screen.dart';
import 'package:tutorx/screens/Tutor/timer_screen.dart';
import 'package:tutorx/screens/Tutor/tutor_homepage.dart';
import 'package:tutorx/screens/student/student_homepage.dart';
import 'package:tutorx/screens/student/timer_screen_student.dart';
import 'package:tutorx/utils/base_client.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';

class BidWidget extends StatefulWidget {
  final tuition_id;

  const BidWidget({required this.tuition_id});

  @override
  _BidWidgetState createState() => _BidWidgetState();
}

class _BidWidgetState extends State<BidWidget> {
  var name = '';
  var subject = '';
  var topic = '';
  var rate = 0;
  var imageUrl =
      'https://www.pngkey.com/png/detail/52-523516_empty-profile-picture-circle.png';

  bool check = false;

  checkIfAccepted() async {
    while (!check) {
      final response =
          await BaseClient().get("/pendingTuitions").catchError((err) {});

      //Idrees Mapping not working
      List<dynamic> res = json.decode(response);
      List<PendingTuitions> pendingTuitions =
          res.map((json) => PendingTuitions.fromJson(json)).toList();

      // final List<Offer> offers = [];

      for (var i = 0; i < res.length; i++) {
        var start = res[0]["start_time"];
        // print(start);
        var uid = await SharedPreferencesUtils.getUID();
        // print("UID : $uid");
        // print("TID :$start");
        if (start != null) {
          check = true;
          break;
        }
      }
    }
    print('Tutit id');
    print(tuition_id);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TimerScreenStd(
            tuition_id: widget.tuition_id, subject: subject, topic: topic, rate: rate),
      ),
    );
    // Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    check = false;

    fetchDetails();
  }

  fetchDetails() async {
    print(widget.tuition_id);
    final response = await BaseClient()
        .get("/pendingTuitions/${widget.tuition_id}")
        .catchError((err) {});
    var res = json.decode(response);
    var student_id = res['tutor_id'];

    final response_user =
        await BaseClient().get("/user/$student_id").catchError((err) {});
    var res_user = json.decode(response_user);
    setState(() {
      name = res_user['fullname'];
      // print(name);

      topic = res['topic'];
      // print(topic);
      subject = res['subject'];
      rate = res['bid_amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    checkIfAccepted();
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 170),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 60,
          ),
          SizedBox(height: 16),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          Text(
            'Subject: $subject',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Topic: $topic',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Hourly Rate: \Rs:$rate/hr',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  primary: Colors.green, // Change this to the desired color
                ),
                child: Text(
                  'Call',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  backgroundColor:
                      Colors.red, // Change this to the desired color
                ),
                child: Text(
                  'Helpline',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ChosenTutor extends StatelessWidget {
  final tuition_id;
  const ChosenTutor({required this.tuition_id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
      ),
      body: Center(
        child: BidWidget(
          tuition_id: tuition_id,
        ),
      ),
    );
  }
}
