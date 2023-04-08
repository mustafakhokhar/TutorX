import 'package:flutter/material.dart';

class TutorLoadingBidScreen extends StatefulWidget {
  const TutorLoadingBidScreen({Key? key}) : super(key: key);

  @override
  _TutorLoadingBidScreenState createState() => _TutorLoadingBidScreenState();
}

class _TutorLoadingBidScreenState extends State<TutorLoadingBidScreen> {
  @override
  Widget build(BuildContext context) {
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
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF583BE8)), // change color
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
                    'Waiting for the Students to Respond . . .',
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
          Positioned(
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            bottom: screenHeight * 0.1, // push button upwards
            child: SizedBox(
              width: buttonWidth, // adjust width of the button
              height: buttonHeight,
              child: Padding(
                padding: EdgeInsets.only(top: buttonHeight * 0.1), // add top padding
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 73, 47, 207),
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(buttonHeight * 0.5),
                    ),
                  ),
                  onPressed: () {
                    // Add your onPressed logic here
                  },
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                      fontSize: textSize * 1.5,
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
