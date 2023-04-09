import 'package:flutter/material.dart';
import 'package:tutorx/widgets/asking_signin.dart';
import 'package:tutorx/widgets/asking_signup.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: screenHeight * 0.15),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Level up your\nlearning\nFind your ',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: screenWidth * 0.1 * textScaleFactor,
                          fontFamily: 'JakartaSans',
                        ),
                      ),
                      TextSpan(
                        text: 'tutor',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: screenWidth * 0.1 * textScaleFactor,
                          fontFamily: 'JakartaSans',
                          color: Color(0xFFF2FF53),
                        ),
                      ),
                      TextSpan(
                        text: '\ntoday!',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: screenWidth * 0.1 * textScaleFactor,
                          fontFamily: 'JakartaSans',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  AskingSignup(),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  AskingSignIn(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
