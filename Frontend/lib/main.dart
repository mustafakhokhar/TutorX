import 'package:flutter/material.dart';
import 'package:tutorx/screens/common/welcome_screen.dart';
import 'package:tutorx/welcome_screen.dart';
import 'package:tutorx/utils/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
            // title: 'FlutterFire Samples',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.indigo,
              brightness: Brightness.dark,
            ),
            home: Welcomescreen(),
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
