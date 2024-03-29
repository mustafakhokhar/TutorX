import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorx/screens/Tutor/tutor_homepage.dart';
import 'package:tutorx/screens/Tutor/tutor_login.dart';
import 'package:tutorx/screens/common/sign_up_success.dart';
import 'package:tutorx/screens/student/select_location.dart';
import 'package:tutorx/utils/colors.dart';
import 'package:tutorx/utils/auth.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';
import 'package:tutorx/widgets/reusable_widgets.dart';
import 'package:tutorx/utils/base_client.dart';
import 'package:tutorx/models/user_model.dart';

class TutorSignUpScreen extends StatefulWidget {
  const TutorSignUpScreen({super.key});

  @override
  State<TutorSignUpScreen> createState() => _TutorSignUpScreen();
}

class _TutorSignUpScreen extends State<TutorSignUpScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _fullnameTextController = TextEditingController();
  TextEditingController _phonenumberTextController = TextEditingController();
  TextEditingController _educationlevelTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          // Your background widgets here
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  height: screenHeight * 0.9,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        hexStringToColor("583BE8"),
                        hexStringToColor("312181"),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    Text(
                      "Getting Started",
                      style: TextStyle(
                        fontSize: screenWidth * 0.08,
                        fontFamily: 'JakartaSans',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF2FF53),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Text(
                      "Create an account to continue!",
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        fontFamily: 'JakartaSans',
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFF2FF53),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    SizedBox(
                      width: screenWidth * 0.85,
                      height: screenHeight * 0.08,
                      child: reusableTextField(
                        "Full Name",
                        Icons.person_2_outlined,
                        false,
                        _fullnameTextController,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    SizedBox(
                      width: screenWidth * 0.85,
                      height: screenHeight * 0.08,
                      child: reusableTextField(
                        "Phone Number",
                        Icons.person_2_outlined,
                        false,
                        _phonenumberTextController,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    SizedBox(
                      width: screenWidth * 0.85,
                      height: screenHeight * 0.08,
                      child: reusableTextField(
                        "Email",
                        Icons.person_2_outlined,
                        false,
                        _emailTextController,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    SizedBox(
                      width: screenWidth * 0.85,
                      height: screenHeight * 0.08,
                      child: reusableTextField(
                        "Password",
                        Icons.lock_outline,
                        true,
                        _passwordTextController,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    SizedBox(
                        width: screenWidth * 0.85,
                        height: screenHeight * 0.08,
                        child: reusableTextField(
                            "Education level",
                            Icons.lock_outline,
                            true,
                            _educationlevelTextController)),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    SizedBox(
                        width: screenWidth * 0.85,
                        height: screenHeight * 0.08,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height *
                                      0.04, // adjust as needed
                                ),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          onPressed: () async {
                            String email = _emailTextController.text.trim();
                            String password =
                                _passwordTextController.text.trim();

                            UserCredential? userCredential =
                                await Authentication.signUpWithEmail(
                              context: context,
                              email: email,
                              password: password,
                            );

                            if (userCredential != null) {
                              String uidTemp = (userCredential.user?.uid)!;
                              var user = Users(
                                  uid: uidTemp,
                                  fullname: _fullnameTextController.text,
                                  student: false);

                              var response = await BaseClient()
                                  .post("/user", user)
                                  .catchError((err) {});

                              // if (response == null) return;
                              // debugPrint("successful");
                              await SharedPreferencesUtils
                                  .StoreUserDetailsInCache(uidTemp);

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignUpSuccessful(),
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height *
                                  0.02, // adjust as needed
                              horizontal: MediaQuery.of(context).size.width *
                                  0.1, // adjust as needed
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: 'JakartaSans',
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery.of(context).size.width *
                                    0.04, // adjust as needed
                              ),
                            ),
                          ),
                        )),
                    Center(
                        child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TutorSignIn(),
                          ),
                        );
                      },
                      child: Text(
                        "Already have an account? Sign In",
                        style: TextStyle(
                          color: Color(0xFFF2FF53),
                          fontSize: MediaQuery.of(context).size.width *
                              0.03, // adjust as needed
                        ),
                      ),
                    ))
                  ])))
        ]));
  }
}
