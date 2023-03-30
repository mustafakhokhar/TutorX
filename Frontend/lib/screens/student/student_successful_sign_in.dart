import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class StudentSignUpSuccessful extends StatefulWidget {
  const StudentSignUpSuccessful({super.key});

  @override
  State<StudentSignUpSuccessful> createState() =>  StudentSignUpSuccessfulState();
}

class  StudentSignUpSuccessfulState extends State<StudentSignUpSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
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
                  padding: EdgeInsets.only(top: 100.0,bottom: 10.0),
                  child: Container(
                    width: 175.0,
                    height: 175.0,
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
                SizedBox(height: 50.0),
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
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 70.0,vertical: 10.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Congratulations! You are now part of our learning community. Let's find the right tutor for you and start achieving your goals!",
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
                  padding: EdgeInsets.only(top: 50.0),
                  child: SizedBox(
                    height: 60, // Set button height to 80
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
                      onPressed: () {
                        // Add your onPressed logic here
                      },
                      child: Text(
                        'CONTINUE',
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