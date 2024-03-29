import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tutorx/screens/student/inperson_bids_from_tutor.dart';
import 'package:tutorx/widgets/loader_stud.dart';


import '../../utils/base_client.dart';
import '../../utils/shared_preferences_utils.dart';

class InpersonStudentFindingTutorLoadingScreen extends StatefulWidget {
  const InpersonStudentFindingTutorLoadingScreen({Key? key}) : super(key: key);

  @override
  State<InpersonStudentFindingTutorLoadingScreen> createState() =>
      InpersonStudentFindingTutorLoadingScreenState();
}

class InpersonStudentFindingTutorLoadingScreenState
    extends State<InpersonStudentFindingTutorLoadingScreen> {
  double circleSize = 0.0;
  void _showOverlay(BuildContext context) {
    
  
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      // Navigator.pushReplacementNamed(context, '/nextScreen');
      Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  // InpersonStudentFindingTutorLoadingScreen(),
                  BidsScreenInPerson(),
            ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;

    String? getStudentId(String id, dynamic array) {
      Iterable<dynamic> decodedArray = json.decode(array);
      for (var obj in decodedArray) {
        if (obj["student_id"] == id) {
          return obj["_id"];
        }
      }
      return null;
    }

    // Set the circle size based on the screen size
    circleSize = width * 0.4;
    // _showOverlay(context);



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
                  width: 100,
                  height: 100,
                  child: HomePage(),
                ),
                SizedBox(height: height * 0.03), // add some spacing
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.05), // add top padding
                  child: Text(
                    'Finding Tutors . . .',
                    style: TextStyle(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF2FF53),
                      fontFamily: 'JakartaSans',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: width * 0.05,
            right: width * 0.05,
            bottom: height * 0.1, // push button upwards
            child: SizedBox(
              width: width * 0.9, // adjust width of the button
              height: height * 0.1,
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.01), // add top padding
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF2FF53),
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(height * 0.05),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    String uid = await SharedPreferencesUtils.getUID();
                    var tuitions = await BaseClient()
                        .get("/pendingTuitions")
                        .catchError((err) {});
                    var current_tuition = getStudentId(uid, tuitions);
                    print(current_tuition.toString());
                    // var current_tuition = '643207480d580cf0841fd030';
                    var response = await BaseClient()
                        .delete("/pendingTuitions/${current_tuition}")
                        .catchError((err) {});
                  },
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                      fontSize: width * 0.08,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'JakartaSans',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
