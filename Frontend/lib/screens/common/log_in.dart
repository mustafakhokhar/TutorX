import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorx/screens/student/student_homepage.dart';
import 'package:tutorx/screens/common/forget_password.dart';
import 'package:tutorx/utils/colors.dart';
import 'package:tutorx/widgets/reusable_widgets.dart';
import 'package:tutorx/utils/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("583BE8"),
              hexStringToColor("312181"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              50, MediaQuery.of(context).size.height * 0.2, 50, 0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Color(0xFFF2FF53),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF2FF53),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
              ),
              Text(
                "Let's Sign You In",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF2FF53),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              reusableTextField("Email or Phone Number",
                  Icons.person_2_outlined, false, _emailController),
              SizedBox(
                height: 20,
              ),
              reusableTextField(
                  "Password", Icons.lock_outline, true, _passwordController),
              SizedBox(
                height: 40,
              ),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => StudentHomepage(
                                userCredential: userCredential,
                              ),
                            ),
                          );
                          // Navigator.pushNamed(context, '/mapScreen');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF2FF53),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                //Forgot Password button
                onPressed: () {
                  // Perform forgot password action here
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ForgetPasswordScreen()));
                },
                style: TextButton.styleFrom(
                  // backgroundColor: Color(0xFFF2FF53),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                ),
                child: Text(
                  "Forgot password?",
                  style: TextStyle(fontSize: 16, color: Color(0xFFF2FF53)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
