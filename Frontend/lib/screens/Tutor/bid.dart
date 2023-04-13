import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorx/models/bids_model.dart';
import 'package:tutorx/screens/Tutor/tutor_loading_for_bid.dart';
import 'package:tutorx/utils/base_client.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';

import 'offers_screen.dart';

class BidScreen extends StatefulWidget {
  BidScreen(student_id, tuition_id);

  @override
  _BidScreenState createState() => _BidScreenState();
}

class _BidScreenState extends State<BidScreen> {
  final TextEditingController _bidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // return Scaffold(

    //   body: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Enter Bid',
    //           style: TextStyle(
    //             fontSize: 16.0,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         SizedBox(height: 10.0),
    //         TextFormField(
    //           controller: _bidController,
    //           keyboardType: TextInputType.number,
    //           decoration: InputDecoration(
    //             border: OutlineInputBorder(),
    //             hintText: 'Enter your bid amount',
    //           ),
    //         ),
    //         SizedBox(height: 10.0),
    //         ElevatedButton(
    //           onPressed: () {
    //             // Implement your button logic here
    //             print('Bid submitted: ${_bidController.text}');
    //           },
    //           child: Text('Submit Bid'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      // backgroundColor: Colors.black87,
      backgroundColor: Color.fromARGB(255, 5, 5, 5).withOpacity(0.5),

      body: Padding(
        padding: EdgeInsetsDirectional.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.4),

            Text(
              'Enter the amount',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'JakartaSans'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Container(
              height: 100, // Set the height of the container
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color(0xFF583BE8), width: 2.0), // Purple border
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Bid Amount',
                      style: TextStyle(color: Color(0xFFF2FF53)),
                    ),
                  ),
                  SizedBox(height: 8), // Added padding between the elements
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: TextFormField(
                        controller: _bidController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your bid amount'.padLeft(24),
                          suffixText: 'Rs'.padRight(10),
                          suffixStyle: TextStyle(
                              color: Color(
                                  0xFFF2FF53)), // Added color to the suffix text
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.04),

            // ElevatedButton(
            //   onPressed: () {
            //     // Implement your button logic here
            //     print('Bid submitted: ${_bidController.text}');
            //   },
            //   child: Text('Submit Bid'),
            // ),
            ElevatedButton(
              child: Text('Bid',
                  style: TextStyle(
                      fontFamily: 'JakartaSans',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 255, 255, 255))),
              onPressed: () async {
                print('Bid submitted: ${_bidController.text}');
                var uid = await SharedPreferencesUtils.getUID();
                var name = await SharedPreferencesUtils.getUserName();

                var bid_obj = Bids(
                  tuitionId: tuition_id,
                  studentId: student_id,
                  tutorId: uid,
                  tutorName: name,
                  bidAmount: int.parse(_bidController.text),
                );
                final response = await BaseClient()
                    .post("/bids", bid_obj)
                    .catchError((err) {});

                // print(response);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TutorLoadingBidScreen(),
                  ),
                );
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(Size(130, 45)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF583BE8)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          print(student_id);

          // TutorLoadingBidScreen

          // String uid = await SharedPreferencesUtils.getUID();
          //           var response = await BaseClient()
          //               .delete("/activeTutors/${uid}")
          //               .catchError((err) {
          //             print(err);
          //           });
          // if (response!= null) {

          Navigator.of(context).pop();
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

  @override
  void dispose() {
    _bidController.dispose();
    super.dispose();
  }
}
