import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../welcome_screen.dart';
import '../student/student_sign_up.dart';
import 'log_in.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 141),
            Text.rich(
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
            SizedBox(height: 220),
            SizedBox(
              height: 52,
              width: 247,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xFF583BE8))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentSignUpScreen()),
                  );
                },
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
                text: TextSpan(children: <TextSpan>[
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
                            builder: (context) => WelcomeScreen()),
                      );
                    })
            ]))
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Text('Login Page'),
      ),
    );
  }
}
