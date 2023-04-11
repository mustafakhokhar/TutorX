import 'package:flutter/material.dart';
import 'package:tutorx/routes.dart';
import 'package:tutorx/screens/Tutor/bid.dart';
import 'package:tutorx/screens/Tutor/offers_screen.dart';
import 'package:tutorx/screens/Tutor/timer_screen.dart';
import 'package:tutorx/screens/Tutor/tutor_homepage.dart';
import 'package:tutorx/screens/Tutor/tutor_loading_for_bid.dart';
import 'package:tutorx/screens/common/first_screen.dart';
import 'package:tutorx/screens/student/Tutor_accepted.dart';
import 'package:tutorx/screens/student/student_homepage.dart';
import 'package:tutorx/screens/student/total_charge.dart';
import 'package:tutorx/utils/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tutorx/firebase_options.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';

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
  @override
  void initState() {
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
            // home: ChargePage(),

            home: FutureBuilder<bool>(
              future: SharedPreferencesUtils.getisLoggedIn(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  bool isLoggedIn = snapshot.data!;
                  if (isLoggedIn) {
                    return FutureBuilder<bool>(
                        future: SharedPreferencesUtils.getisStudent(),
                        builder: (BuildContext context,
                            AsyncSnapshot<bool> snapshot) {
                          if (snapshot.hasData) {
                            bool isStudent = snapshot.data!;
                            // print(isLoggedIn);
                            // print(isStudent);
                            return isStudent
                                ? StudentHompage()
                                : TutorHomepage();
                          } else {
                            return CircularProgressIndicator();
                          }
                        });
                  } else {
                    return FirstScreen();
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          
          );
        }
        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Color.fromARGB(255, 179, 15, 15),
          ),
        );
        // Otherwise, show something whilst waiting for initialization to complete
      },
    );
  }
}
