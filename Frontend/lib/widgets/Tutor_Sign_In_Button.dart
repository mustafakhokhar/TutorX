import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TutorSignInButton extends StatefulWidget {
  @override
  _TutorSignInButton createState() => _TutorSignInButton();
}

class _TutorSignInButton extends State<TutorSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 0, 0, 0)),
            )
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 0, 0, 0)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () async {
                // setState(() {
                //   _isSigningIn = true;
                // });
                // User? user =
                // await Authentication.signInWithGoogle(context: context);

                // setState(() {
                //   _isSigningIn = false;
                // });

                // if (user != null) {
                //   Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(
                //       builder: (context) => UserInfoScreen(
                //         user: user,
                //       ),
                //     ),
                //   );
                // }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Image(
                    //   image: AssetImage("lib/assets/google_logo.png"),
                    //   height: 35.0,
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Are you a Tutor?',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
