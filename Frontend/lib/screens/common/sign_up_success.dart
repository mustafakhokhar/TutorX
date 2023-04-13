import 'package:flutter/material.dart';
import 'package:tutorx/screens/Tutor/tutor_homepage.dart';
import 'package:tutorx/screens/student/student_homepage.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';

class SignUpSuccessful extends StatefulWidget {
  const SignUpSuccessful({super.key});

  @override
  State<SignUpSuccessful> createState() => SignUpSuccessfulState();
}

class SignUpSuccessfulState extends State<SignUpSuccessful> {
  var isStudent = false;
  var studentText =
      "Congratulations! You are now part of our learning community. Let's find the right tutor for you and start achieving your goals!";
  var tutorText =
      "Congratulations! You are now a part of our dedicated team of tutors . Let's find your first student and help them reach their full potential.";

  checkStudent() async {
    var check = await SharedPreferencesUtils.getisStudent();

    setState(() {
      isStudent = check;
    });
  }

  @override
  void initState() {
    checkStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        // width: double.infinity,
        // height: double.infinity,
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.05, bottom: screenHeight * 0.009),
                child: Container(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Color.fromARGB(255, 7, 6, 6),
                    size: 120.0,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Text(
                  'Sign Up Successful!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 32,
                    fontFamily: 'JakartaSans',
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
                            SizedBox(height: screenHeight*0.001),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 70.0, vertical: 10.0),
                alignment: Alignment.center,
                child: Text(
                  isStudent ? studentText : tutorText,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 15,
                    fontFamily: 'JakartaSans',
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 50.0),
              Padding(
                                padding: EdgeInsets.only(top: screenHeight*0.01),

                child: SizedBox(
                  height: screenHeight*0.1,  // Set button height to 80
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      // Set minWidth to 150 and height to 80
                      minimumSize: Size(300, 80),
                    ),
                    onPressed: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              isStudent ? StudentHompage() : TutorHomepage(),
                        ),
                      );
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'JakartaSans',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color hexStringToColor(String hexString) {
    return Color(int.parse(hexString.substring(0, 6), radix: 16) + 0xFF000000);
  }
}
