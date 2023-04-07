import 'package:flutter/material.dart';

class StudentFindingTutorLoadingScreen extends StatefulWidget {
  const StudentFindingTutorLoadingScreen({Key? key}) : super(key: key);

  @override
  State<StudentFindingTutorLoadingScreen> createState() =>
      StudentFindingTutorLoadingScreenState();
}

class StudentFindingTutorLoadingScreenState
    extends State<StudentFindingTutorLoadingScreen> {
  
  double circleWidth = 100.0;
  double circleHeight = 100.0;

  @override
  Widget build(BuildContext context) {
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
                  width: circleWidth,
                  height: circleHeight,
                  child: CircularProgressIndicator(
                    strokeWidth: 10.0, // increase border width
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow), // change color
                  ),
                ),
                SizedBox(height: 16.0), // add some spacingg
                Padding(
                  padding: EdgeInsets.only(top: 60.0), // add top padding
                  child: Text(
                    'Finding Tutors . . .',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF2FF53),
                      fontFamily: 'JakartaSans',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16.0,
            right: 16.0,
            bottom: 80.0, // push button upwards
            child: SizedBox(
              width: 1.0, // adjust width of the button
              height: 70.0,
              child: Padding(
                padding: EdgeInsets.only(top: 8.0), // add top padding
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF2FF53),
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    // Add your onPressed logic here
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                      fontSize: 30.0,
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
