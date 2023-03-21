import 'package:flutter/material.dart';

class ForgetPasswordButton extends StatefulWidget {
  @override
  _ForgetPasswordButton createState() => _ForgetPasswordButton();
}

class _ForgetPasswordButton extends State<ForgetPasswordButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
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
                        'Forget Password',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
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
