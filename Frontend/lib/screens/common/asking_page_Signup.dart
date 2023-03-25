import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tutorx/screens/Tutor/tutor_sign_up.dart';
import 'package:tutorx/screens/student/student_sign_up.dart';
import 'package:tutorx/utils/colors.dart';

class AskingPageSignUp extends StatefulWidget {
  const AskingPageSignUp({super.key});

  @override
  State<AskingPageSignUp> createState() => _AskingPageSignUpState();
}

class _AskingPageSignUpState extends State<AskingPageSignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Your background widgets here
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    hexStringToColor("583BE8"),
                    hexStringToColor("312181"),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Who are you?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFFF2FF53),
                        fontSize: 32,
                        fontFamily: 'JakartaSans',
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                      width: 230,
                      height: 60,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 0, 0, 0)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentSignUpScreen()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 32.0,
                          ),
                          child: Text(
                            'I\'m a Student',
                            style: TextStyle(
                              fontFamily: 'JakartaSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                      width: 230,
                      height: 60,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 0, 0, 0)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TutorSignUpScreen()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 32.0,
                          ),
                          child: Text(
                            'I\'m a Tutor',
                            style: TextStyle(
                              fontFamily: 'JakartaSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ))
                ])
                // Your dynamic content here
                ),
          ),
        ],
      ),
    );
  }
}
