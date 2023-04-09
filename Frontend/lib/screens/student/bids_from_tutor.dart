import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:tutorx/models/bids_model.dart';

import 'package:tutorx/models/pending_tuitions_model.dart';
import 'package:tutorx/models/user_model.dart';
import 'package:tutorx/screens/Tutor/bid.dart';
import 'package:tutorx/screens/Tutor/tutor_homepage.dart';
import 'package:tutorx/screens/student/student_homepage.dart';
import 'package:tutorx/utils/base_client.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';

var time = 1;

class Bid {
  final String? tutor_name;
  final int? rate;
  // final double price;

  Bid({
    this.tutor_name,
    this.rate,
  });
}

class BidWidget extends StatelessWidget {
  final Bid bid;

  const BidWidget({required this.bid});

  void _acceptBid(BuildContext context) {
    // Code to accept the Bid goes here
    // For example:
  }

  void _cancelBid(BuildContext context) {
    // Code to accept the Bid goes here
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
                child: Text('Accept',
                    style: TextStyle(
                        fontFamily: 'JakartaSans',
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                    color: Color(0xFFF2FF53))),

                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => BidScreen(),
                  //   ),
                  // );

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
              ),
              ElevatedButton(
                child: Text(
                  'Decline',
                  style: TextStyle(
                      fontFamily: 'JakartaSans',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFF2FF53)),
                ),
                onPressed: () => _cancelBid(context),
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
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BidsScreen extends StatefulWidget {
  @override
  _BidsScreenState createState() => _BidsScreenState();
}

class _BidsScreenState extends State<BidsScreen> {
  List<Bid> _Bids = [];
  late Timer _timer;

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

    // final bids_response = bidsFromJson(response);

    print(response.runtimeType);
    print(response);
    // List<dynamic> res = json.decode(response);
    // List<Bids> pendingTuitions =
    //     resp.map((json) => PendingTuitions.fromJson(json)).toList();
    // print(bids_response.bidAmount);
    //Idrees Mapping not working
    List<dynamic> res = json.decode(response);
    // print(res[0]["student_id"]);
    // List<Bid> bids_response =
    //     response.map((json) => Bids.fromJson(json)).toList();
    
    // print(bids_response);
    final List<Bid> bids_list = [];
    // var tutor = bids_response.tutorName;
    // var rate_offered = bids_response.bidAmount;
    // Bid temp = Bid(tutor_name: tutor, rate: rate_offered);
    // bids_list.insert(0, temp);

    for (var i = 0; i < res.length; i++) {
      // print(i);
      var tutorName = res[i]["tutor_name"];
      var rate = res[i]["bid_amount"];
      // print(tutorName);
      Bid temp = Bid(
          tutor_name: tutorName, rate: rate);
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
          // String uid = await SharedPreferencesUtils.getUID();
          //           var response = await BaseClient()
          //               .delete("/activeTutors/${uid}")
          //               .catchError((err) {
          //             print(err);
          //           });
          // if (response!= null) {

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  // StudentFindingTutorLoadingScreen(),
                  StudentHompage(),
            ),
          );
          // }
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
