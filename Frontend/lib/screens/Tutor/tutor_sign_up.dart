import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorx/screens/Tutor/tutor_login.dart';
import 'package:tutorx/screens/student/select_location.dart';
import 'package:tutorx/utils/colors.dart';
import 'package:tutorx/utils/auth.dart';
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
    Future<void> StoreUserDetailsInCache(String uid) async {
      var response = await BaseClient().get("/user/$uid").catchError((err) {});
      var user = usersFromJson(response);
      // print('Here: ${user.fullname}');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fullname', user.fullname);
      await prefs.setString('uid', user.uid);
      await prefs.setBool('student', user.student);
      await prefs.setBool('isLoggedIn', true);
    }
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          // Your background widgets here
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
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
                      "Getting Started",
                      style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'JakartaSans',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF2FF53)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Create an account to continue!",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'JakartaSans',
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFF2FF53)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: reusableTextField(
                            "Full Name",
                            Icons.person_2_outlined,
                            false,
                            _fullnameTextController)),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: reusableTextField(
                            "Phone Number",
                            Icons.person_2_outlined,
                            false,
                            _phonenumberTextController)),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: reusableTextField(
                            "Email",
                            Icons.person_2_outlined,
                            false,
                            _emailTextController)),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: reusableTextField("Password", Icons.lock_outline,
                            true, _passwordTextController)),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: reusableTextField(
                            "Education level",
                            Icons.lock_outline,
                            true,
                            _educationlevelTextController)),
                    SizedBox(height: 20),
                    SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 0, 0, 0)),
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
                                await StoreUserDetailsInCache(uidTemp);


                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => MapScreen(),
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 32.0,
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: 'JakartaSans',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
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
                        style: TextStyle(color: Color(0xFFF2FF53)),
                      ),
                    ))
                  ])))
        ]));
  }
}
