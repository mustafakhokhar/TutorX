import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:tutorx/models/pending_tuitions_model.dart';
import 'package:tutorx/models/user_model.dart';
import 'package:tutorx/screens/Tutor/bid.dart';
import 'package:tutorx/screens/Tutor/tutor_homepage.dart';
import 'package:tutorx/utils/base_client.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';

var time = 1;
var student_id;
var tuition_id;

class Offer {
  final String? subject;
  final String? topic;
  final String? student_name;
  // final double price;

  Offer({
    required this.subject,
    required this.topic,
    required this.student_name,
    // required this.price,
  });
}

class OfferWidget extends StatelessWidget {
  final Offer offer;
  const OfferWidget({required this.offer});

  void _acceptOffer(BuildContext context) {
    // Code to accept the offer goes here
    // For example:
  }

  void _cancelOffer(BuildContext context) {
    // Code to accept the offer goes here
    // For example:
    showDialog(
        context: context,
        builder: (_) => AlertDialog(title: Text('Cancelled')));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF583BE8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Name: ${offer.student_name}",
                style: TextStyle(
                    fontFamily: 'JakartaSans',
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Subject: ${offer.subject}",
                style: TextStyle(
                    fontFamily: 'JakartaSans',
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFF2FF53))),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Topic: ${offer.topic}",
                  style: TextStyle(
                      fontFamily: 'JakartaSans',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFF2FF53)))),
          ButtonBar(
            children: [
              ElevatedButton(
                child: Text('Accept',
                    style: TextStyle(
                        fontFamily: 'JakartaSans',
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 255, 255, 255))),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BidScreen(student_id, tuition_id),
                    ),
                  );
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(Size(130, 45)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 0, 0, 0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 75,
              ),
              ElevatedButton(
                child: Text(
                  'Reject',
                  style: TextStyle(
                      fontFamily: 'JakartaSans',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                onPressed: () => _cancelOffer(context),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(Size(130, 45)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 0, 0, 0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
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

class OffersScreen extends StatefulWidget {
  final teaching_mode;
  final tutor_lat;
  final tutor_lon;
  const OffersScreen(
      {required this.teaching_mode,
      required this.tutor_lat,
      required this.tutor_lon});

  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  List<Offer> _offers = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 2), (_) {
      _fetchOffers();
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to prevent further callbacks
    super.dispose();
  }

  Future<void> _fetchOffers() async {
    // Code to fetch offers from the database
    // List<Offer> offers = await _database.getOffers();
    final response =
        await BaseClient().get("/pendingTuitions").catchError((err) {});

    //Idrees Mapping not working
    List<dynamic> res = json.decode(response);
    List<PendingTuitions> pendingTuitions =
        res.map((json) => PendingTuitions.fromJson(json)).toList();

    final List<Offer> offers = [];
    if (widget.teaching_mode == 0) {
      print("IN INPERSON FLOW");

      // INperson
      for (PendingTuitions tuition in pendingTuitions) {
        // isWithin5Km()
        var lat1 = widget.tutor_lat;
        var lat2 = tuition.latitude;
        var lon1 = widget.tutor_lon;
        var lon2 = tuition.longitude;
        if (lat2 != null && lon2 != null) {
          if (isWithin5Km(lat1, lon1, lat2, lon2)) {
            var id = tuition.studentId;
            student_id = id;
            tuition_id = tuition.tuition_id;
            final response =
                await BaseClient().get("/user/${id}").catchError((err) {});
            final users = usersFromJson(response);

            var name = users.fullname;
            // print(name);
            Offer temp = Offer(
                subject: tuition.subject,
                topic: tuition.topic,
                student_name: name);
            offers.insert(0, temp);
          }
        }
      }
    } else {
      // Online
      print("IN ONLINE FLOW");

      for (PendingTuitions tuition in pendingTuitions) {
        var lat = tuition.latitude;
        if (lat == null) {
          var id = tuition.studentId;
          student_id = id;
          tuition_id = tuition.tuition_id;
          final response =
              await BaseClient().get("/user/${id}").catchError((err) {});
          final users = usersFromJson(response);

          var name = users.fullname;
          // print(name);
          Offer temp = Offer(
              subject: tuition.subject,
              topic: tuition.topic,
              student_name: name);
          offers.insert(0, temp);
        }
      }
      // if (mounted) {
      //   setState(() {
      //     _offers = offers;
      //   });
      // }
    }

    if (mounted) {
      setState(() {
        _offers = offers;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black87,
      backgroundColor: Color.fromARGB(255, 5, 5, 5).withOpacity(0.5),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 45),
            Expanded(
              child: ListView.builder(
                itemCount: _offers.length,
                itemBuilder: (BuildContext context, int index) {
                  return OfferWidget(offer: _offers[index]);
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          String uid = await SharedPreferencesUtils.getUID();
          var response = await BaseClient()
              .delete("/activeTutors/${uid}")
              .catchError((err) {
            print(err);
          });
          if (response != null) {
            Navigator.of(context).pop();
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) =>
            //         // StudentFindingTutorLoadingScreen(),
            //         TutorHomepage(),
            //   ),
            // );
          }
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
      // backgroundColor: Colors.black,
    );
  }
}

bool isWithin5Km(double lat1, double lon1, double lat2, double lon2) {
  const double radius = 6371; // Earth's radius in km
  double dLat = _toRadians(lat2 - lat1);
  double dLon = _toRadians(lon2 - lon1);
  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_toRadians(lat1)) *
          cos(_toRadians(lat2)) *
          sin(dLon / 2) *
          sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double distance = radius * c;
  return distance <= 5;
}

double _toRadians(double degrees) {
  return degrees * pi / 180;
}
