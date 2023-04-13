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
import 'package:tutorx/screens/student/tuition_in_progress.dart';
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
    print(widget.tuition_id);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TuitionInProgress(
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
    final double screenHeight = MediaQuery.of(context).size.height;
final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 41, 41, 41),
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(horizontal: screenWidth*0.05, vertical: screenWidth*0.4),
          padding: EdgeInsets.symmetric(horizontal: screenWidth*0.1, vertical: screenWidth*0.045),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenWidth*0.2),
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 60,
          ),
          SizedBox(height: screenWidth*0.02),
          Text(
            name,
            style: TextStyle(
                    fontFamily: 'JakartaSans',
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255)),
                textAlign: TextAlign.center,
          ),
          SizedBox(height: screenWidth*0.1),
          Text(
            'Subject: $subject',
            style: TextStyle(
                    fontFamily: 'JakartaSans',
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 255, 255, 255)),
          ),
          SizedBox(height: screenWidth*0.02),
          Text(
            'Topic: $topic',
            style: TextStyle(
                    fontFamily: 'JakartaSans',
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 255, 255, 255)),
          ),
          SizedBox(height: screenWidth*0.02),
          Text(
            'Hourly Rate: \Rs:$rate/hr',
            style: TextStyle(
                    fontFamily: 'JakartaSans',
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 255, 255, 255)),
          ),
          SizedBox(height: screenWidth*0.09),
          ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding:
                          EdgeInsets.symmetric(horizontal: 0.09 * MediaQuery.of(context).size.width,
                      vertical: 0.019 * MediaQuery.of(context).size.height),
                      primary: Color(0xFF583BE8), 
                ),
                child: Text(
                  'Call',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'JakartaSans',
                    fontSize: 0.023 * MediaQuery.of(context).size.height,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              
              
            ],
          ),
        ],
      ),
    ));
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
      body: Center(
        child: BidWidget(
          tuition_id: tuition_id,
        ),
      ),
    );
  }
}
