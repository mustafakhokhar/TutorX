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
import 'package:restart_app/restart_app.dart';

class BidWidgetStd extends StatefulWidget {
  // final Bid bid;
  final tuition_id;
  final subject;
  final topic;
  final rate;

  const BidWidgetStd(
      {required this.tuition_id,
      required this.subject,
      required this.topic,
      required this.rate});
  @override
  _BidWidgetStdState createState() => _BidWidgetStdState();
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

class _BidWidgetStdState extends State<BidWidgetStd> {
  var name = '';
  double due_payment = 0.0;
  var imageUrl =
      'https://www.pngkey.com/png/detail/52-523516_empty-profile-picture-circle.png';

  bool isPaid = false;

  @override
  void initState() {
    fetchDetails();
    super.initState();
  }

  fetchDetails() async {
    // print(widget.tuition_id);
    var tutu = widget.tuition_id;
    // var customObjectId = CustomObjectId.fromHexString(
    //     tutu); // Create a CustomObjectId from the widget.tuition_id value
    // var obj = {"_id": customObjectId.hexString};
    // print(obj);
    // print(obj.runtimeType);
    // final jsonObj = json.encode(obj);
    // print("HEREEE: ${json.decode(jsonObj)}");
    final response = await BaseClient()
        .get("/confirmedTuitions/${widget.tuition_id}")
        .catchError((err) {});
    var res = json.decode(response);
    var student_id = res['student_id'];
    var tutor_id = res['tutor_id'];

    // print(res);

    final response_user =
        await BaseClient().get("/user/$tutor_id").catchError((err) {});
    var res_user = json.decode(response_user);

    // print(res['tutor_id']);
    setState(() {
      name = res_user['fullname'];
      due_payment = res['amount'];
      // print(due_payment);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 41, 41, 41),
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, vertical: screenWidth * 0.4),
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.2, vertical: screenWidth * 0.045),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // add the hamburger menu icon here

              SizedBox(height: screenWidth * 0.02),
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                radius: 60,
              ),
              SizedBox(height: screenWidth * 0.04),
              Text(
                name,
                style: TextStyle(
                    fontFamily: 'JakartaSans',
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenWidth * 0.07),
              Text(
                'Subject: ${widget.subject}',
                style: TextStyle(
                    fontFamily: 'JakartaSans',
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              SizedBox(height: screenWidth * 0.02),
              Text(
                'Topic: ${widget.topic}',
                style: TextStyle(
                    fontFamily: 'JakartaSans',
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              SizedBox(height: screenWidth * 0.02),
              Text(
                'Hourly Rate: RS ${widget.rate}/hr',
                style: TextStyle(
                    fontFamily: 'JakartaSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              SizedBox(height: screenWidth * 0.08),
              Text(
                'Charges Due:',
                style: TextStyle(
                    fontFamily: 'JakartaSans',
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              Text(
                'Rs:${due_payment.ceil()}',
                style: TextStyle(
                    fontFamily: 'JakartaSans',
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFF2FF53)),
              ),
              SizedBox(height: screenWidth * 0.04),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isPaid = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.09 * MediaQuery.of(context).size.width,
                      vertical: 0.019 * MediaQuery.of(context).size.height),
                  primary: Color(0xFF583BE8),
                ),
                child: Text(
                  isPaid ? 'Paid' : 'Pay',
                  style: TextStyle(
                    fontFamily: 'JakartaSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 0.023 * MediaQuery.of(context).size.height,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              )
            ],
          ),
        ));
  }
}

class ChargePageStd extends StatelessWidget {
  final tuition_id;
  final subject;
  final topic;
  final rate;

  const ChargePageStd(
      {required this.tuition_id,
      required this.subject,
      required this.topic,
      required this.rate});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 0, 0, 0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        // appBar: AppBar(),
        body: Center(
          child: BidWidgetStd(
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
                builder: (context) => StudentHompage(),
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
      ),
    );
  }
}
