import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:tutorx/screens/Tutor/two_buttons.dart';
import 'package:tutorx/widgets/navbar.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'homepage_button_tutor.dart';

var teaching_mode = 1;
bool _isOnline = true;
bool _isInPerson = false;

class TutorHomepage extends StatefulWidget {
  const TutorHomepage({super.key});

  @override
  State<TutorHomepage> createState() => _TutorHomepageState();
}

class _TutorHomepageState extends State<TutorHomepage> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  @override
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
            margin: EdgeInsets.fromLTRB(
                0, screenSize.height * 0.15, 0, screenSize.height * 0.4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Button(
                    teaching_mode: teaching_mode,
                  ),
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

class MyButton extends StatefulWidget {
  const MyButton({super.key});

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isOnline = true;
              _isInPerson = false;
              print('Tutor is ready for Online Tuition');
              teaching_mode = 1; // 1 for online
            });
          },
          child: Container(
            width: 162,
            height: 59,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _isOnline ? Color(0xFFF2FF53) : Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              'Online',
              style: TextStyle(
                color: _isOnline ? Colors.black : Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'JakartaSans',
              ),
            ),
          ),
        ),
        SizedBox(
          width: 17,
        ),
        InkWell(
          onTap: () {
            setState(() {
              _isOnline = false;
              _isInPerson = true;
              print('Tutor is ready for Offline Tuition');
              teaching_mode = 0;
            });
          },
          child: Container(
            width: 162,
            height: 59,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _isInPerson ? Color(0xFFF2FF53) : Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              'In-Person',
              style: TextStyle(
                color: _isInPerson ? Colors.black : Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'JakartaSans',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// class TutorHomepage extends StatelessWidget {
// GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  
//   @override
//   Widget build(BuildContext context) {
//     final FirebaseAuth _auth = FirebaseAuth.instance;
//     final Size screenSize = MediaQuery.of(context).size;

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark(),
//       home: Scaffold(
//         key: _scaffoldState,
//         drawer: NavBar(),
//         body: Center(
//           child: Container(
//             margin: EdgeInsets.fromLTRB(0, screenSize.height * 0.15, 0, screenSize.height * 0.4),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Button(),
//                 ),
//                 SizedBox(
//                   height: screenSize.height * 0.05,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     MyButton(),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.black,
//           onPressed: () {
//             _scaffoldState.currentState?.openDrawer();
//           },
//           shape: RoundedRectangleBorder(
//             side: BorderSide(width: 3, color: Colors.white),
//             borderRadius: BorderRadius.circular(screenSize.width * 0.1),
//           ),
//           child: Icon(
//             Icons.menu,
//             size: screenSize.width * 0.1,
//             color: Colors.white,
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
//         backgroundColor: Colors.black,
//       ),
//     );
//   }
// }