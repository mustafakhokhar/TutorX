import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tutorx/screens/common/forget_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorx/screens/common/sign_in_success.dart';
import 'package:tutorx/utils/auth.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';
import 'package:tutorx/widgets/reusable_widgets.dart';
import 'package:tutorx/utils/colors.dart';
import 'package:tutorx/widgets/Google_Sign_In_Button.dart';
import 'package:tutorx/utils/base_client.dart';

class StudentSignIn extends StatefulWidget {
  const StudentSignIn({super.key});

  @override
  State<StudentSignIn> createState() => _StudentSignInState();
}

class _StudentSignInState extends State<StudentSignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
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
                    "Let's sign you in",
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

                                if (user["student"] == true) {
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
                                          Text("The user is not a Student!!"),
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
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    child: GoogleSignInButton(),
                  )
                ])),
          ),
        ],
      ),
    );
  }
}

// StoreInCache(String uid) async {
//   var response = await BaseClient().get("/user/$uid").catchError((err) {});
//   var user = usersFromJson(response);
  

//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString('fullname', user.fullname);
//   prefs.setBool('student', user.student);
//   prefs.setString('uid', user.uid);
// }
