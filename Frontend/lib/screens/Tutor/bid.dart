import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorx/models/bids_model.dart';
import 'package:tutorx/screens/Tutor/tutor_loading_for_bid.dart';
import 'package:tutorx/utils/base_client.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';

import 'offers_screen.dart';

class BidScreen extends StatefulWidget {
  BidScreen(student_id,tuition_id);

  @override
  _BidScreenState createState() => _BidScreenState();
}

class _BidScreenState extends State<BidScreen> {
  final TextEditingController _bidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenPadding = screenWidth * 0.04;
    final buttonWidth = screenWidth * 0.3;
    final buttonHeight = screenHeight * 0.06;
    final headingFontSize = screenWidth * 0.05;
    final textFieldFontSize = screenWidth * 0.045;
    final buttonFontSize = screenWidth * 0.045;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 5, 5).withOpacity(0.5),
      body: Padding(
        padding: EdgeInsets.all(screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.35),
            Text(
              'Enter the amount',
              style: TextStyle(
                fontSize: headingFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            TextFormField(
              controller: _bidController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your bid amount',
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              style: TextStyle(fontSize: textFieldFontSize),
            ),
            SizedBox(height: screenHeight * 0.03),
            ElevatedButton(
              child: Text(
                'Bid',
                style: TextStyle(
                  fontFamily: 'JakartaSans',
                  fontSize: buttonFontSize,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
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

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TutorLoadingBidScreen(),
                  ),
                );
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  Size(buttonWidth, buttonHeight),
                ),
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
        },
        shape: RoundedRectangleBorder(
          side: BorderSide(width: screenWidth * 0.007, color: Colors.white),
          borderRadius: BorderRadius.circular(screenWidth * 0.15),
        ),
        child: Icon(
          Icons.arrow_back,
          size: screenWidth * 0.1,
          color: Colors.white,
        ),
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
