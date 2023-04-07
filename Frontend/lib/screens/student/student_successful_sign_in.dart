import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class StudentSignUpSuccessful extends StatefulWidget {
  const StudentSignUpSuccessful({super.key});

  @override
  State<StudentSignUpSuccessful> createState() =>  StudentSignUpSuccessfulState();
}

class StudentSignUpSuccessfulState extends State<StudentSignUpSuccessful> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("583BE8"),
              hexStringToColor("312181"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.15, bottom: screenHeight * 0.02),
                child: Container(
                  width: screenWidth * 0.45,
                  height: screenWidth * 0.45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Color.fromARGB(255, 7, 6, 6),
                    size: screenWidth * 0.28,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Text(
                  'Sign Up Successful!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: screenWidth * 0.08,
                    fontFamily: 'JakartaSans',
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeight * 0.002),
              Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15, vertical: screenHeight * 0.01),
                alignment: Alignment.center,
                child: Text(
                  "Congratulations! You are now part of our learning community. Let's find the right tutor for you and start achieving your goals!",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: screenWidth * 0.035,
                    fontFamily: 'JakartaSans',
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.05),
                child: SizedBox(
                  height: screenHeight * 0.1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenHeight * 0.05),
                      ),
                      minimumSize: Size(screenWidth * 0.6, screenHeight * 0.1),
                    ),
                    onPressed: () {
                      // Add your onPressed logic here
                    },
                    child: Text(
                      'CONTINUE',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'JakartaSans',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color hexStringToColor(String hexString) {
    return Color(int.parse(hexString.substring(0, 6), radix: 16) + 0xFF000000);
  }
}
