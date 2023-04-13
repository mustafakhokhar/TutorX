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
import 'package:tutorx/utils/base_client.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';
import 'package:http/http.dart' as http;

import '../student/timer_screen_student.dart';

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

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  fetchDetails() async {
    print(widget.tuition_id);
    final response = await BaseClient()
        .get("/pendingTuitions/${widget.tuition_id}")
        .catchError((err) {});
    var res = json.decode(response);
    var student_id = res['student_id'];

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
    // checkIfAccepted();
    final double screenHeight = MediaQuery.of(context).size.height;
final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.black,
        body:Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 41, 41, 41),
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(horizontal: screenWidth*0.05, vertical: screenWidth*0.4),
          padding: EdgeInsets.symmetric(horizontal: screenWidth*0.1, vertical: screenWidth*0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenWidth*0.15),
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
                    color: Color.fromARGB(255, 255, 255, 255))
          ),
          SizedBox(height: screenWidth*0.02),
          Text(
            'Hourly Rate: \Rs:$rate/hr',
            style: TextStyle(
                    fontFamily: 'JakartaSans',
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 255, 255, 255))
          ),
          SizedBox(height: screenWidth*0.1),


          ElevatedButton(
            onPressed: () async {
              // Code for starting the tuition
              // final obj = {
              //   "name": "John Smith",
              //   "age": 30,
              //   "email": "john.smith@example.com"
              // };
              // final objJSON = jsonEncode(obj);
              // final res1 = await BaseClient()
              //     .get("/pendingTuitions/$tuition_id")
              //     .catchError((err) {});

              final response = await put("/pendingTuitions/$tuition_id/start")
                  .catchError((err) {});
              // final dec = jsonDecode(objJSON);
              print(response);

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TimerScreen(
                      tuition_id: tuition_id,
                      subject: subject,
                      topic: topic,
                      rate: rate),
                ),
              );
            },
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
              'Start Tuition',
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

// Sample data
// final Bid sampleBid = Bid(
//   tutorName: 'Ronaldeen',
//   subject: 'Mathematics',
//   topic: 'Calculus',
//   hourlyRate: 25,
//   imageUrl:
//       'https://pbs.twimg.com/media/B5uu_b4CEAEJknA?format=jpg&name=medium',
// );

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ExamplePage extends StatelessWidget {
  final tuition_id;
  const ExamplePage({required this.tuition_id});

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

Future<dynamic> put(String api) async {
  var client = http.Client();

  var url = Uri.parse(baseUrl + api);

  var _headers = {
    'Content-Type': 'application/json',
  };
  var response = await client.put(url, headers: _headers);

  if (response.statusCode == 200) {
    return response.body;
  } else {}
}
