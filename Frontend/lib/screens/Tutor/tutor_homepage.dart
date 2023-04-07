import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorx/screens/Tutor/two_buttons.dart';
import 'package:tutorx/utils/auth.dart';
import 'package:tutorx/screens/student/select_location.dart';
import 'package:tutorx/widgets/navbar.dart';

import 'homepage_button_tutor.dart';

class TutorHomepage extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Size screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        key: _scaffoldState,
        drawer: NavBar(),
        body: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, screenSize.height * 0.15, 0, screenSize.height * 0.4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Button(),
                ),
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(),
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            _scaffoldState.currentState?.openDrawer();
          },
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 3, color: Colors.white),
            borderRadius: BorderRadius.circular(screenSize.width * 0.1),
          ),
          child: Icon(
            Icons.menu,
            size: screenSize.width * 0.1,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        backgroundColor: Colors.black,
      ),
    );
  }
}