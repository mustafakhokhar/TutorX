import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorx/screens/common/sign_up_success.dart';
// import 'package:tutorx/screens/common/map_temp.dart';
import 'package:tutorx/screens/student/student_homepage.dart';
import 'package:tutorx/screens/student/select_location.dart';
import 'package:tutorx/screens/student/student_login.dart';
import 'package:tutorx/utils/api.dart';
import 'package:tutorx/utils/base_client.dart';
import 'package:tutorx/utils/colors.dart';
import 'package:tutorx/utils/auth.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';
import 'package:tutorx/widgets/reusable_widgets.dart';
import 'package:tutorx/models/user_model.dart';

class StudentSignUpScreen extends StatefulWidget {
  const StudentSignUpScreen({Key? key}) : super(key: key);

  @override
  _StudentSignUpScreenState createState() => _StudentSignUpScreenState();
}

class _StudentSignUpScreenState extends State<StudentSignUpScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _fullnameTextController = TextEditingController();
  TextEditingController _phonenumberTextController = TextEditingController();
  TextEditingController _educationlevelTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenRatio = screenWidth / screenHeight;

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
                      height: screenHeight * 0.05,
                    ),
                    Text(
                      "Getting Started",
                      style: TextStyle(
                          fontSize: screenWidth * 0.08,
                          fontFamily: 'JakartaSans',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF2FF53)),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      "Create an account to continue!",
                      style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          fontFamily: 'JakartaSans',
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFF2FF53)),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    SizedBox(
                        width: screenWidth * 0.85,
                        height: screenHeight * 0.08,
                        child: reusableTextField(
                            "Full Name",
                            Icons.person_2_outlined,
                            false,
                            _fullnameTextController)),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    SizedBox(
                        width: screenWidth * 0.85,
                        height: screenHeight * 0.08,
                        child: reusableTextField(
                            "Phone Number",
                            Icons.person_2_outlined,
                            false,
                            _phonenumberTextController)),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    SizedBox(
                        width: screenWidth * 0.85,
                        height: screenHeight * 0.08,
                        child: reusableTextField(
                            "Email",
                            Icons.person_2_outlined,
                            false,
                            _emailTextController)),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    SizedBox(
                        width: screenWidth * 0.85,
                        height: screenHeight * 0.08,
                        child: reusableTextField("Password", Icons.lock_outline,
                            true, _passwordTextController)),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    SizedBox(
                        width: screenWidth * 0.5,
                        height: screenHeight * 0.08,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 0, 0, 0)),
                          ),
                          onPressed: () async {
                            print("Button pressed");
                            String email = _emailTextController.text.trim();
                            String password =
                                _passwordTextController.text.trim();

                            UserCredential? userCredential =
                                await Authentication.signUpWithEmail(
                              context: context,
                              email: email,
                              password: password,
                            );

                            // var response = await BaseClient()
                            //     .get("/students")
                            //     .catchError((err) {});
                            // if (response == null) return;
                            // var users = userFromJson(response)

                            if (userCredential != null) {
                              String uid_temp = (userCredential.user?.uid)!;

                              var user = Users(
                                uid: uid_temp,
                                fullname: _fullnameTextController.text,
                                student: true,
                              );

                              var response = await BaseClient()
                                  .post("/user", user)
                                  .catchError((err) {});
                              print("successful working");
                              await SharedPreferencesUtils
                                  .StoreUserDetailsInCache(uid_temp);

                              // if (response == null) return;

                              print("successful");

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignUpSuccessful(),
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.01,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.1,
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: 'JakartaSans',
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Center(
                        child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => StudentSignIn(),
                          ),
                        );
                      },
                      child: Text(
                        "Already have an account? Sign In",
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          fontFamily: 'JakartaSans',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF2FF53),
                        ),
                      ),
                    ))
                  ])))
        ]));
  }
}