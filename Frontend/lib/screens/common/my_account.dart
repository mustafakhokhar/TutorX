import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorx/utils/base_client.dart';
import 'package:tutorx/utils/colors.dart';
import 'package:tutorx/widgets/reusable_widgets.dart';
import 'package:tutorx/models/user_model.dart';

import '../../utils/shared_preferences_utils.dart';

class myAccount extends StatefulWidget {
  const myAccount({super.key});

  @override
  State<myAccount> createState() => _myAccountstate();
}

class _myAccountstate extends State<myAccount> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _fullnameTextController = TextEditingController();
  TextEditingController _phonenumberTextController = TextEditingController();
  TextEditingController _educationlevelTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    Future<void> ClearUserDetailsFromCache() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fullname', '');
      await prefs.setString('uid', '');
      await prefs.setBool('student', false);
      await prefs.setBool('isLoggedIn', false);
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
                      "My Account",
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
                            print("Button pressed");
                            String name = _fullnameTextController.text.trim();

                            String uid = await SharedPreferencesUtils.getUID();
                            print(uid);
                            var user = Users(
                              uid: uid,
                              fullname: name,
                              student: true,
                            );
                            var response = await BaseClient()
                                .put("/user", user)
                                .catchError((err) {});
                            if (uid != null) {
                              // updateUserName(uid, name);

                              print("successful");

                              Navigator.of(context).pop();
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
                    SizedBox(
                      height: 20,
                    ),
                  ])))
        ]));
  }
}
