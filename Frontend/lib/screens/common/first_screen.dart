import 'package:flutter/material.dart';
import 'package:tutorx/widgets/asking_signin.dart';
import 'package:tutorx/widgets/asking_signup.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.only(top: 141),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Level up your\nlearning\nFind your ',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 40,
                          fontFamily: 'JakartaSans',
                        ),
                      ),
                      TextSpan(
                        text: 'tutor',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 40,
                          fontFamily: 'JakartaSans',
                          color: Color(0xFFF2FF53),
                        ),
                      ),
                      TextSpan(
                        text: '\ntoday!',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 40,
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
                  AskingSignup(),
                  SizedBox(
                    height: 28,
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
