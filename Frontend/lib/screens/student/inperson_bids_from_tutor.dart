import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:tutorx/models/bids_model.dart';

import 'package:tutorx/models/pending_tuitions_model.dart';
import 'package:tutorx/models/user_model.dart';
import 'package:tutorx/screens/Tutor/bid.dart';
import 'package:tutorx/screens/Tutor/offers_screen.dart';
import 'package:tutorx/screens/Tutor/tutor_homepage.dart';
import 'package:tutorx/screens/student/student_homepage.dart';
import 'package:tutorx/screens/student/tutor_chosen_bid.dart';
import 'package:tutorx/utils/base_client.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';

var time = 1;

class Bid {
  final String? tutor_name;
  final int? rate;
  final String? tuition_id;
  final String? tutor_id;
  final String? student_id;

  Bid(
      {this.tutor_name,
      this.rate,
      this.tuition_id,
      this.student_id,
      this.tutor_id});
}

class BidWidget extends StatelessWidget {
  final Bid bid;

  const BidWidget({required this.bid});

  // void _acceptBid(BuildContext context) {
  //   // Code to accept the Bid goes here
  //   // For example:
  // }

  // void _cancelBid(BuildContext context) {
  //   // Code to accept the Bid goes here
  //   // For example:
  //   showDialog(
  //       context: context,
  //       builder: (_) => AlertDialog(title: Text('Cancelled')));
  // }

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
            child: Text("Name: ${bid.tutor_name}",
                style: TextStyle(
                    fontFamily: 'JakartaSans',
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 255, 255, 255))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Hourly Rate: ${bid.rate}/hr",
                style: TextStyle(
                    fontFamily: 'JakartaSans',
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFF2FF53))),
          ),
          ButtonBar(
            children: [
              ElevatedButton(
                onPressed: () async {
                  // ACCEPT
                  // final response_tid = await BaseClient()
                  //     .get("/pendingTuitions/${bid.tuition_id}")
                  //     .catchError((err) {});

                  // var res = json.decode(response_tid);

                  var selected_id = bid.tuition_id;
                  print("BID id: ${bid.tuition_id}");

                  final myJSONobject = {
                    'tutor_id': bid.tutor_id,
                    'bid_amount': bid.rate
                  };

                  final response = await BaseClient()
                      .put("/pendingTuitions/${selected_id}", myJSONobject)
                      .catchError((err) {});

                  print("SUCCCESSSSS");
                  var uid = await SharedPreferencesUtils.getUID();
                  print(uid);
                  final response_deletion = await BaseClient()
                      .delete("/bids/${uid}")
                      .catchError((err) {});

                  print("deleted successfully ");

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChosenTutor(tuition_id: selected_id,),
                    ),
                  );
                },
                style: ButtonStyle(
                  // fixedSize: MaterialStateProperty.all<Size>(Size(130, 45)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 0, 0, 0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                child: Text('Accept',
                    style: TextStyle(
                        fontFamily: 'JakartaSans',
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFF2FF53))),
              ),
              ElevatedButton(
                onPressed: () async {
                  // DECLINE FUNCTIONALITY
                  // remove from the bid table
                  var uid = await SharedPreferencesUtils.getUID();
                  print(uid);
                  final response = await BaseClient()
                      .delete("/bids/${uid}")
                      .catchError((err) {});

                  print("deleted successfully ");
                  print(response);

                  


                },
                style: ButtonStyle(
                  // fixedSize: MaterialStateProperty.all<Size>(Size(130, 45)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 0, 0, 0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                child: Text(
                  'Decline',
                  style: TextStyle(
                      fontFamily: 'JakartaSans',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFF2FF53)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BidsScreenInPerson extends StatefulWidget {
  @override
  _BidsScreenInPersonState createState() => _BidsScreenInPersonState();
}

class _BidsScreenInPersonState extends State<BidsScreenInPerson> {
  List<Bid> _Bids = [];
  late Timer _timer;

  void _navigateToScreenAfter2Minutes(BuildContext context) {
    Future.delayed(Duration(minutes: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StudentHompage()),
      );
    });
  }

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 2), (_) {
      _fetchBids();
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to prevent further callbacks
    super.dispose();
  }

  Future<void> _fetchBids() async {
    // Code to fetch Bids from the database
    // List<Bid> Bids = await _database.getBids();
    var uid = await SharedPreferencesUtils.getUID();
    // var uid = "12345667";

    final response =
        await BaseClient().get("/bids/${uid}").catchError((err) {});

    List<dynamic> res = json.decode(response);

    // print(bids_response);
    final List<Bid> bids_list = [];

    for (var i = 0; i < res.length; i++) {
      // print(i);
      var tutorName = res[i]["tutor_name"];
      var rate = res[i]["bid_amount"];
      var t_id = res[i]["tuition_id"];
      var tutor_id = res[i]["tutor_id"];
      var student_id = res[i]["student_id"];
      // print(tutorName);
      Bid temp = Bid(
          tutor_name: tutorName,
          rate: rate,
          tuition_id: t_id,
          tutor_id: tutor_id);
      bids_list.insert(0, temp);
    }
    // for (Bid bid in res) {
    //   var tutorName = bid["tutor_name"];
    //   print(tutorName);
    //   var bid_rate = bid.rate;
    //   // print(name);
    //   // Bid temp = Bid(
    //   //     tutor_name: tutorName, rate: bid_rate);
    //   // bids_list.insert(0, temp);
    // }
    if (mounted) {
      setState(() {
        _Bids = bids_list;
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
                itemCount: _Bids.length,
                itemBuilder: (BuildContext context, int index) {
                  return BidWidget(bid: _Bids[index]);
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          _timer.cancel(); // Cancel the timer to prevent further callbacks

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  // StudentFindingTutorLoadingScreen(),
                  StudentHompage(),
            ),
          );
          // }
          super.dispose();
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
