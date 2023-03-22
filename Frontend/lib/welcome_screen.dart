import 'package:flutter/material.dart';
import 'package:tutorx/utils/colors.dart';
import 'package:tutorx/widgets/Google_Sign_In_Button.dart';
import 'package:tutorx/widgets/Student_Sign_Up_Button.dart';
import 'package:tutorx/widgets/Tutor_Sign_In_Button.dart';
import 'package:tutorx/widgets/Email_Sign_In_Button.dart';
import 'package:tutorx/widgets/Forget_password_Button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        hexStringToColor("583BE8"),
        hexStringToColor("312181"),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Image.asset(
                          'lib/assets/x.png',
                          height: 160,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'TutorX',
                        style: TextStyle(
                          wordSpacing: 4,
                          fontWeight: FontWeight.w800,
                          fontSize: 40,
                          fontFamily: 'JakartaSans',
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Text(
                        'Student Sign-In',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w800,
                          fontFamily: 'JakartaSans',
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    EmailSignInButton(),
                    GoogleSignInButton(),
                    StudentSignUpButton(),

                    // Row(
                    //   children: [
                    //     StudentSignUpButton(),
                    //     SizedBox(
                    //     ),
                    // ForgetPasswordButton()
                    //   ],
                    // ),
                    TutorSignInButton(),
                  ],
                )
                // FutureBuilder(
                //   future: Authentication.initializeFirebase(context: context),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasError) {
                //       // print(snapshot.error);
                //       return Text('Error initializing Firebase');
                //     } else if (snapshot.connectionState == ConnectionState.done) {
                //       return Column(
                //         children: [
                //           EmailSignInButton(),
                //           GoogleSignInButton(),
                //           StudentSignUp()
                //         ],
                //       );
                //     }
                //     return CircularProgressIndicator(
                //       valueColor: AlwaysStoppedAnimation<Color>(
                //         Colors.orange,
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
