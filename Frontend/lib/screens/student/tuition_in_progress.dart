import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tutorx/models/pending_tuitions_model.dart';
import 'package:tutorx/screens/Tutor/student_accepted_bid.dart';
import 'package:tutorx/screens/student/online_student_total_charge.dart';
import 'package:tutorx/utils/base_client.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';

class TuitionInProgress extends StatefulWidget {
  final tuition_id;
  final subject;
  final topic;
  final rate;

  const TuitionInProgress(
      {required this.tuition_id,
      required this.subject,
      required this.topic,
      required this.rate});

  @override
  _TuitionInProgressState createState() => _TuitionInProgressState();
}

var tid ='';

class _TuitionInProgressState extends State<TuitionInProgress> {
bool check = false;

  checkIfAccepted() async {
    print(check);
    while (!check) {
      final response =
          await BaseClient().get("/confirmedTuitions").catchError((err) {});

      //Idrees Mapping not working
      var res = json.decode(response);

      // print(res);

      for (var i = 0; i < res.length; i++) {
        var tid = res[i]["tuition_id"];
        // var tid = "6436ec4a13f67e5fd2136512";
        // print("TID: ${res[i]["tuition_id"]}");
        // print("given: ${widget.tuition_id}");
        if (tid == widget.tuition_id) {
          print("FOUND");
          check = true;
          break;
        }
      }

    }
     Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChargePageStd(
          tuition_id: widget.tuition_id,
          subject: widget.subject,
          topic: widget.topic,
          rate: widget.rate,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
bool check = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkIfAccepted();

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double circleSize = screenWidth * 0.3;
    final double textSize = screenHeight * 0.03;
    final double buttonWidth = screenWidth * 0.8;
    final double buttonHeight = screenHeight * 0.1;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: circleSize,
                  height: circleSize,
                  child: CircularProgressIndicator(
                    strokeWidth: circleSize * 0.1, // increase border width
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF583BE8)), // change color
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // add some spacing
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.1,
                    left: screenWidth * 0.1,
                    right: screenWidth * 0.1,
                  ), // add top padding
                  child: Text(
                    'Tuition In Progress . . .',
                    style: TextStyle(
                      fontSize: textSize,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontFamily: 'JakartaSans',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          // Positioned(
          //   left: screenWidth * 0.1,
          //   right: screenWidth * 0.1,
          //   bottom: screenHeight * 0.1, // push button upwards
          //   child: SizedBox(
          //     width: buttonWidth, // adjust width of the button
          //     height: buttonHeight,
          //     child: Padding(
          //       padding:
          //           EdgeInsets.only(top: buttonHeight * 0.1), // add top padding
          //       child: ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //           primary: Color.fromARGB(255, 73, 47, 207),
          //           onPrimary: Colors.black,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(buttonHeight * 0.5),
          //           ),
          //         ),
          //         onPressed: () {
          //           // Add your onPressed logic here
          //         },
          //         child: Text(
          //           'CANCEL',
          //           style: TextStyle(
          //             fontSize: textSize * 1.5,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.black,
          //             fontFamily: 'JakartaSans',
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
