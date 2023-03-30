import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorx/utils/auth.dart';
import 'package:tutorx/screens/common/map_temp.dart';

class TutorHomepage extends StatelessWidget {
  final String user_uid;

  const TutorHomepage({required this.user_uid}) : super();

  @override
  Widget build(BuildContext context) {
    // final User? user = user_uid.user;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome $user_uid'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome $user_uid',
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
                          MapScreen(user_uid: user_uid),
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
            // child: SignOutButton(),
          ],
        ),
      ),
    );
  }
}
