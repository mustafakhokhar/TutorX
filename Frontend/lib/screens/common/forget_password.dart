import 'package:flutter/material.dart';
import 'package:tutorx/screens/student/student_login.dart';
import 'package:tutorx/utils/auth.dart';
import 'package:tutorx/utils/colors.dart';
import 'package:tutorx/widgets/reusable_widgets.dart';

// import 'package:tutorx/screens/common/log_in.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

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
              height: screenSize.height * 0.9,
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
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  Text(
                    "Change your Password",
                    style: TextStyle(
                      fontSize: screenSize.width * 0.07,
                      fontFamily: 'JakartaSans',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF2FF53),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  Text(
                    "Enter your email",
                    style: TextStyle(
                      fontSize: screenSize.width * 0.03,
                      fontFamily: 'JakartaSans',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF2FF53),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  SizedBox(
                    width: screenSize.width * 0.85,
                    height: screenSize.height * 0.08,
                    child: reusableTextField(
                      'Email',
                      Icons.person_2_outlined,
                      false,
                      _emailController,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  SizedBox(
                    width: screenSize.width * 0.5,
                    height: screenSize.height * 0.07,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      onPressed: () async {
                        Authentication.forgetPassword(
                          context: context,
                          email: _emailController.text,
                        );

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => StudentSignIn(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenSize.height * 0.016,
                          horizontal: screenSize.width * 0.04,
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontFamily: 'JakartaSans',
                            fontWeight: FontWeight.w600,
                            fontSize: screenSize.width * 0.035,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.03,
                  ),
                  Center(),
                ],)))
        ]));
  }
}
