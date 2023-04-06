import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutorx/models/user_model.dart';
import 'package:tutorx/routes.dart';
import 'package:tutorx/screens/Tutor/tutor_homepage.dart';
import 'package:tutorx/screens/common/first_screen.dart';
import 'package:tutorx/screens/student/student_findingatutor_loading_screen.dart';
import 'package:tutorx/screens/student/student_homepage.dart';
import 'package:tutorx/utils/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tutorx/firebase_options.dart';
import 'package:tutorx/utils/base_client.dart';
// import 'package:tutorx/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;
  var isLoggedin = false;
  // late bool check;
  var current_user;
  var uid_1;
  int check = 2;
  // var uid;

  checkIfLoggedIn() async {
    auth.authStateChanges().listen((User? user) async {
      if (user != null && mounted) {
        setState(() {
          current_user = auth.currentUser;
          isLoggedin = true;
        });
        var uid = auth.currentUser?.uid;
        print(uid);
        var response =
            await BaseClient().get("/user/$uid").catchError((err) {});
        var user = usersFromJson(response);
        if (user.student) {
          setState(() {
            check = 1;
          });
          print('Student it is');
        } else {
          setState(() {
            check = 0;
          });
          print('Tutor it is');
        }
      }
    });
  }

  @override
  void initState() {
    checkIfLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: Authentication.initializeFirebase(context: context),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Text(
            'error',
            textDirection: TextDirection.ltr,
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: appRoutes,
            theme: ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            ),
            // home: FirstScreen(),

            home: isLoggedin
                ? ((check == 1)
                    ? StudentHompage(user_uid: current_user.uid)
                    : ((check == 2)
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.black,
                            ),
                          )
                        : TutorHomepage()))
                // TutorHomepage(user_uid: current_user.uid)))
                : FirstScreen(),
            // home: TutorLoadingBidScreen(),
          );
        }
        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.black,
          ),
        );
        // Otherwise, show something whilst waiting for initialization to complete
      },
    );
  }
}
