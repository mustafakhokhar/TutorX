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
      'https://pbs.twimg.com/media/B5uu_b4CEAEJknA?format=jpg&name=medium';

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

    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.1,
        vertical: size.height * 0.2,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: size.width * 0.15,
          ),
          SizedBox(height: size.height * 0.002),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: size.height * 0.02,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.04),
          Text(
            'Subject: $subject',
            style: TextStyle(
              color: Colors.white,
              fontSize: size.height * 0.017,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            'Topic: $topic',
            style: TextStyle(
              color: Colors.white,
              fontSize: size.height * 0.017,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            'Hourly Rate: \Rs:$rate/hr',
            style: TextStyle(
              color: Colors.white,
              fontSize: size.height * 0.017,
            ),
          ),
          SizedBox(height: size.height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.1,
                    vertical: size.height * 0.02,
                  ),
                  primary: Colors.green, // Change this to the desired color
                ),
                child: Text(
                  'Call',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: size.height * 0.02,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.1,
                    vertical: size.height * 0.02,
                  ),
                  backgroundColor:
                      Colors.red, // Change this to the desired color
                ),
                child: Text(
                  'Helpline',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: size.height * 0.02,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.05),
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
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
              ),
              padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.15, 
              vertical: MediaQuery.of(context).size.height * 0.035,),
              backgroundColor: Colors.blue, // Change this to the desired color
            ),
            child: Text(
              'Start Tuition',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.05, // adjust the font size based on screen width
              ),
            ),
          ),
        ],
      ),
    );
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
