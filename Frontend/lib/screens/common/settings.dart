import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorx/screens/common/first_screen.dart';
import 'package:tutorx/utils/auth.dart';
import 'package:tutorx/utils/base_client.dart';
import 'package:tutorx/utils/colors.dart';
import 'package:tutorx/widgets/reusable_widgets.dart';
import 'package:tutorx/models/user_model.dart';

import '../../utils/shared_preferences_utils.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settings();
}

class _settings extends State<settings> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    Future<void> DeleteUserDetailsFromCache() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('fullname');
      await prefs.remove('uid');
      await prefs.remove('student');
      await prefs.remove('isLoggedIn');
      print("Cache Clear");
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
                      "Settings",
                      style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'JakartaSans',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF2FF53)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Container(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                            // Get the current user
                            final User? user =
                                FirebaseAuth.instance.currentUser;

                            if (user == null) {
                              // User is not signed in
                              return;
                            }

                            // Delete the user's account
                            await user.delete();

                            // Sign out the user
                            await Authentication.signOut(context: context);

                            // Delete stored user data from SharedPreferences
                            DeleteUserDetailsFromCache();

                            // Delete stored user data from MongoDB
                            var response = await BaseClient()
                                .delete("/user/${user.uid}")
                                .catchError((err) {
                              print(err);
                            });

                            // Navigate back to first screen
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FirstScreen(),
                              ),
                            );
                            print("Delettion of User: Successful");
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 32.0,
                            ),
                            child: Text(
                              'Delete Account',
                              style: TextStyle(
                                fontFamily: 'JakartaSans',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                  ])))
        ]));
  }
}
