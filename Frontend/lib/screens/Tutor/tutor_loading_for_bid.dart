import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TutorLoadingBidScreen extends StatefulWidget {
  const TutorLoadingBidScreen({super.key});

  @override
  State<TutorLoadingBidScreen> createState() => TutorLoadingBidScreenState();
}

class TutorLoadingBidScreenState extends State<TutorLoadingBidScreen> {
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
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF583BE8)), // change color
                  ),
                ),
                SizedBox(height: 16.0), // add some spacingg
                Padding(
                  padding: EdgeInsets.only(top: 80.0,left:50.0,right:50.0), // add top padding
                  child: Text(
                    'Waiting for the Students to Respond . . .',
                    style: TextStyle(
                      fontSize: 25.0,
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
                    primary: Color.fromARGB(255, 73, 47, 207),
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    // Add your onPressed logic here
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
