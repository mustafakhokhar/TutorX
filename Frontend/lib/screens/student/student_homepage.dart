import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorx/widgets/Sign_Out_Button.dart';
import 'package:tutorx/utils/auth.dart';


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
            SizedBox(height: 20.0),
            OutlinedButton(
                onPressed: () async {
                  await Authentication.signOut(context: context);
                  Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                },
                child: Text("Sign Out")),
                // child: SignOutButton(),
          ],
        ),
      ),
    );
  }
}
