import 'package:flutter/material.dart';

class StudentFindingTutorLoadingScreen extends StatefulWidget {
  const StudentFindingTutorLoadingScreen({Key? key}) : super(key: key);

  @override
  State<StudentFindingTutorLoadingScreen> createState() =>
      StudentFindingTutorLoadingScreenState();
}

class StudentFindingTutorLoadingScreenState
    extends State<StudentFindingTutorLoadingScreen> {
  
  double circleSize = 0.0;

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final size = MediaQuery.of(context).size;
    final double height = size.height;
    final double width = size.width;

    // Set the circle size based on the screen size
    circleSize = width * 0.4;

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
                    strokeWidth: circleSize * 0.06, // increase border width
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow), // change color
                  ),
                ),
                SizedBox(height: height * 0.03), // add some spacing
                Padding(
                  padding: EdgeInsets.only(top: height * 0.05), // add top padding
                  child: Text(
                    'Finding Tutors . . .',
                    style: TextStyle(
                      fontSize: width * 0.06,
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
                  onPressed: () {
                    Navigator.of(context).pop();
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
