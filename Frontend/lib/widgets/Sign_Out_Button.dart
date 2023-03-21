import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text("Sign Out"),
      onPressed: () async {
        try {
          await FirebaseAuth.instance.signOut();
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        } catch (e) {
          print(e.toString());
        }
      },
    );
  }
}
