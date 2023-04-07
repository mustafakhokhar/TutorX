import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tutorx/screens/common/forget_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorx/utils/auth.dart';
import 'package:tutorx/widgets/reusable_widgets.dart';
import 'package:tutorx/utils/colors.dart';
import 'package:tutorx/screens/Tutor/tutor_homepage.dart';
import 'package:tutorx/utils/base_client.dart';
import 'package:tutorx/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorSignIn extends StatefulWidget {
  const TutorSignIn({super.key});

  @override
  State<TutorSignIn> createState() => _TutorSignInState();
}

class _TutorSignInState extends State<TutorSignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
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
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Your background widgets here
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
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
                    height: 40,
                  ),
                  Text(
                    "Let's sign you in (Tutor)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFFF2FF53),
                        fontSize: 32,
                        fontFamily: 'JakartaSans',
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: reusableTextField("Email or Phone Number",
                          Icons.person_2_outlined, false, _emailController)),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: reusableTextField("Password", Icons.lock_outline,
                          true, _passwordController)),
                  SizedBox(
                    height: 30,
                  ),
                  _isLoading
                      ? CircularProgressIndicator()
                      : SizedBox(
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
                              String email = _emailController.text;
                              String password = _passwordController.text;

                              UserCredential? userCredential =
                                  await Authentication.signInWithEmail(
                                context: context,
                                email: email,
                                password: password,
                              );

                              if (userCredential != null) {
                                String uid_temp = (userCredential.user?.uid)!;
                                print("UID: $uid_temp");
                                var response = await BaseClient()
                                    .get("/user/$uid_temp")
                                    .catchError((err) {});
                                if (response == null) return;
                                debugPrint("successful");

                                var user = jsonDecode(response);

                                if (user["student"] == false) {
                                  await StoreUserDetailsInCache(uid_temp);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TutorHomepage(),
                                    ),
                                  );
                                } else {
                                  await Authentication.signOut(
                                      context: context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("The user is not a Tutor!!"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 32.0,
                              ),
                              child: Text(
                                'Sign In',
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
                          builder: (context) => ForgetPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color(0xFFF2FF53),
                        fontFamily: 'JakartaSans',
                        fontSize: 12,
                      ),
                    ),
                  )),
                ])),
          ),
        ],
      ),
    );
  }
}
