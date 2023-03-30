import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutorx/routes.dart';
import 'package:tutorx/screens/common/first_screen.dart';
import 'package:tutorx/screens/student/student_homepage.dart';
import 'package:tutorx/utils/auth.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'package:tutorx/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;
  var isLoggedin = false;
  var current_user ;

  checkIfLoggedIn() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          current_user = auth.currentUser;
          isLoggedin = true;
        });
      }
      print(isLoggedin);
      print(user);
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
            home: isLoggedin ? StudentHompage(user_uid: current_user.uid):FirstScreen(),
            // home: MapScreen(),
          );
        }
        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.orange,
          ),
        );
        // Otherwise, show something whilst waiting for initialization to complete
      },
    );
  }
}
