import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tutorx/screens/common/forget_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorx/screens/common/sign_in_success.dart';
import 'package:tutorx/utils/auth.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';
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

  double _getHeight(double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }

  double _getWidth(double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    final verticalPadding = screenHeight * 0.03;
    final horizontalPadding = screenWidth * 0.1;
    final fontSize = screenHeight * 0.02;

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
              height: _getHeight(0.7),
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
                  topLeft: Radius.circular(_getHeight(0.02)),
                  topRight: Radius.circular(_getHeight(0.02)),
                ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: _getHeight(0.04),
                  ),
                  Text(
                    "Let's sign you in (Tutor)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFF2FF53),
                      fontSize: _getHeight(0.03),
                      fontFamily: 'JakartaSans',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: _getHeight(0.04),
                  ),
                  SizedBox(
                    width: _getWidth(0.85),
                    height: _getHeight(0.08),
                    child: reusableTextField(
                      "Email or Phone Number",
                      Icons.person_2_outlined,
                      false,
                      _emailController,
                    ),
                  ),
                  SizedBox(
                    height: _getHeight(0.02),
                  ),
                  SizedBox(
                    width: _getWidth(0.85),
                    height: _getHeight(0.08),
                    child: reusableTextField(
                      "Password",
                      Icons.lock_outline,
                      true,
                      _passwordController,
                    ),
                  ),
                  SizedBox(
                    height: _getHeight(0.03),
                  ),
                  _isLoading
                      ? CircularProgressIndicator()
                      : SizedBox(
                          width: _getWidth(0.4),
                          height: _getHeight(0.06),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      _getHeight(0.03)),
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
                                  await SharedPreferencesUtils.StoreUserDetailsInCache(uid_temp);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => SignInSuccessful(),
                                    ),
                                  );
                                } else {
                                  await Authentication.signOut(
                                      context: context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text("The user is not a Tutor!!"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: verticalPadding * 0,
                                horizontal: horizontalPadding * 0,
                              ),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontFamily: 'JakartaSans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSize,
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
                        fontSize: fontSize * 0.7,
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
