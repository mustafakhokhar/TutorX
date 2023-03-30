import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorx/utils/auth.dart';
import 'package:tutorx/screens/common/map_temp.dart';
import 'package:tutorx/screens/student/find_tutor_screen.dart';
import 'package:tutorx/screens/student/find_tutor_screen_online.dart';
import 'package:tutorx/widgets/mode_of_teaching_dialog.dart';

class StudentHomepage extends StatelessWidget {
  final UserCredential userCredential;

  const StudentHomepage({required this.userCredential}) : super();

  @override
  Widget build(BuildContext context) {
    final User? user = userCredential.user;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${user?.email}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome ${user?.email}',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          MapScreen(userCredential: userCredential),
                    ),
                  );
                },
                child: Text("MAPS PAGE")),
            SizedBox(height: 20.0),
            OutlinedButton(
                onPressed: () async {
                  await Authentication.signOut(context: context);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
                child: Text("Sign Out")),
            // Add the ElevatedButton to navigate to FindTutorScreen
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FindTutorScreen(),
                  ),
                );
              },
              child: Text('Go to Find Tutor Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
