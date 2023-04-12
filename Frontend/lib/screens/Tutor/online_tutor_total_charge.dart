import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mong;
import 'package:tutorx/models/bids_model.dart';
import 'package:tutorx/models/confirmed_tuitions_model.dart';
import 'package:tutorx/models/pending_tuitions_model.dart';
import 'package:tutorx/models/user_model.dart';
import 'package:tutorx/screens/Tutor/bid.dart';
import 'package:tutorx/screens/Tutor/offers_screen.dart';
import 'package:tutorx/screens/Tutor/tutor_homepage.dart';
import 'package:tutorx/screens/student/student_homepage.dart';
import 'package:tutorx/utils/base_client.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';
import 'package:http/http.dart' as http;

class BidWidget extends StatefulWidget {
  // final Bid bid;
  final tuition_id;
  final subject;
  final topic;
  final rate;

  const BidWidget(
      {required this.tuition_id,
      required this.subject,
      required this.topic,
      required this.rate});
  @override
  _BidWidgetState createState() => _BidWidgetState();
}

class CustomObjectId {
  late mong.ObjectId _objectId;

  // Constructor to generate a new ObjectId
  CustomObjectId() {
    _objectId = mong.ObjectId();
  }

  // Constructor to create a CustomObjectId from a hex string
  CustomObjectId.fromHexString(String hexString) {
    _objectId = mong.ObjectId.fromHexString(hexString);
  }

  // Getter to retrieve the hex string representation of the CustomObjectId
  String get hexString => _objectId.toHexString();

  // Add any additional methods or properties as needed
}

class _BidWidgetState extends State<BidWidget> {
  var name = '';
  double due_payment = 0.0;
  var imageUrl =
      'https://pbs.twimg.com/media/B5uu_b4CEAEJknA?format=jpg&name=medium';

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  fetchDetails() async {
    // print(widget.tuition_id);
    var tutu = widget.tuition_id;
    var customObjectId = CustomObjectId.fromHexString(
        tutu); // Create a CustomObjectId from the widget.tuition_id value
    var obj = {"_id": customObjectId.hexString};
    print(obj);
    print(obj.runtimeType);
    final jsonObj = json.encode(obj);
    print("HEREEE: ${json.decode(jsonObj)}");
    final response = await BaseClient()
        .get("/pendingTuitions/${widget.tuition_id}")
        .catchError((err) {});
    var res = json.decode(response);
    var student_id = res['student_id'];

    print(res);

    final response_confirmed =
        await BaseClient().post("/confirmedTuitions", obj).catchError((err) {});
    print('The Tution id');
    print(widget.tuition_id);

    final response_user =
        await BaseClient().get("/user/$student_id").catchError((err) {});
    var res_user = json.decode(response_user);

    final response_last = await BaseClient()
        .get("/confirmedTuitions/${widget.tuition_id}")
        .catchError((err) {});
    var res_last = json.decode(response_last);
    print('This is res_last');
    print(res_last);

    // print(res['tutor_id']);
    setState(() {
      name = res_user['fullname'];
      due_payment = res_last['amount'];
      print(due_payment);
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchDetails();
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 200),
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
            'Subject: ${widget.subject}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Topic: ${widget.topic}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Hourly Rate: RS ${widget.rate}/hr',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Total Payment: \Rs:${due_payment.ceil()}',
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
                  primary: Colors.green,
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
                  backgroundColor: Colors.red,
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
          )
        ],
      ),
    );
  }
}

class ChargePage extends StatelessWidget {
  final tuition_id;
  final subject;
  final topic;
  final rate;

  const ChargePage(
      {required this.tuition_id,
      required this.subject,
      required this.topic,
      required this.rate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BidWidget(
          tuition_id: tuition_id,
          subject: subject,
          topic: topic,
          rate: rate,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
             Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TutorHomepage(),
              ),
            );
          },
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 3, color: Colors.white),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(
            Icons.arrow_back,
            size: 32,
            color: Colors.white,
          ), // add the hamburger menu icon here
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}

Future<dynamic> post(String api) async {
  var client = http.Client();

  var url = Uri.parse(baseUrl + api);

  var _headers = {
    'Content-Type': 'application/json',
  };
  var response = await client.post(url, headers: _headers);

  if (response.statusCode == 201) {
    return response.body;
  } else {}
}
