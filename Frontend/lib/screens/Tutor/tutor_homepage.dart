import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorx/screens/Tutor/two_buttons.dart';
import 'package:tutorx/utils/auth.dart';
import 'package:tutorx/screens/student/select_location.dart';
import 'package:tutorx/widgets/navbar.dart';

import 'homepage_button_tutor.dart';

class TutorHomepage extends StatelessWidget {
  // final String user_uid;

  // const TutorHomepage({required this.user_uid}) : super();
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  @override
  @override
  Widget build(BuildContext context) {
    // final User? user = user_uid.user;

    final FirebaseAuth _auth = FirebaseAuth.instance;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        key: _scaffoldState,
        drawer: NavBar(),
        body: Center(
            child: Container(
          margin: EdgeInsets.fromLTRB(0, 150, 0, 434),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: Button(),
            ),
            // Expanded(
            //     child: SizedBox(
            //   height: 50,
            // )),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(),
              ],
            )
          ]),
        )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            _scaffoldState.currentState?.openDrawer();
          },
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 3, color: Colors.white),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(
            Icons.menu,
            size: 32,
            color: Colors.white,
          ), // add the hamburger menu icon here
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        backgroundColor: Colors.black,
      ),
      // appBar: AppBar(
      //   title: Text('Welcome $user_uid'),
      // ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         'Welcome $user_uid',
      //         style: TextStyle(
      //           fontSize: 24.0,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       OutlinedButton(
      //           onPressed: () {

      //             Navigator.of(context).push(
      //               MaterialPageRoute(
      //                 builder: (context) =>
      //                     MapScreen(user_uid: user_uid),
      //               ),
      //             );
      //           },
      //           child: Text("MAPS PAGE")),
      //       SizedBox(height: 20.0),
      //       OutlinedButton(
      //           onPressed: () async {
      //             await Authentication.signOut(context: context);
      //             Navigator.of(context).pushNamedAndRemoveUntil(
      //                 '/', (Route<dynamic> route) => false);
      //           },
      //           child: Text("Sign Out")),
      //       // child: SignOutButton(),
      //     ],
      //   ),
      // ),
    );
  }
}
