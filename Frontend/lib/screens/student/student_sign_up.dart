import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutorx/screens/student/student_homepage.dart';
import 'package:tutorx/utils/colors.dart';
import '../../welcome_screen.dart';
import 'package:tutorx/utils/auth.dart';
import 'package:tutorx/widgets/reusable_widgets.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("583BE8"),
          hexStringToColor("312181"),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 85,
                ),
                Text(
                  "Sign up",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF2FF53)),
                ),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Full Name", Icons.person_2_outlined, false,
                    _fullnameTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Password", Icons.lock_outline, true,
                    _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Phone Number", Icons.person_2_outlined,
                    false, _phonenumberTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Email", Icons.person_2_outlined, false,
                    _emailTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Education Level", Icons.person_2_outlined,
                    false, _educationlevelTextController),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    String email = _emailTextController.text.trim();
                    String password = _passwordTextController.text.trim();

                    UserCredential? userCredential =
                        await Authentication.signUpWithEmail(
                      context:
                          context, 
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
                    }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFF2FF53),
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to login screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WelcomeScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Already have an account? Sign In",
                    style: TextStyle(fontSize: 14),
                  ),
                  style: TextButton.styleFrom(
                    primary: Color(0xFFF2FF53),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  ),
                ),
              ],
            )),
      ),
    );
  }

}