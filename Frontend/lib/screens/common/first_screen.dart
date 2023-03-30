import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tutorx/screens/common/asking_page_SignIn.dart';
import 'package:tutorx/screens/common/asking_page_Signup.dart';

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
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF583BE8)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AskingPageSignUp()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 32.0,
                      ),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontFamily: 'JakartaSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Already have an account?',
                          style: TextStyle(
                            color: Color(0xFFF2FF53),
                            fontSize: 15,
                            fontFamily: 'JakartaSans',
                            fontWeight: FontWeight.w400,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AskingPageSignIn()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
