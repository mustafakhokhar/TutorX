import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.red,
          Colors.blue,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Padding(
            padding: EdgeInsets.fromLTRB(
                50, MediaQuery.of(context).size.height * 0.2, 50, 0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                Text(
                  "Let's Sign You In",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Email or Phone Number",
                ),
                // Icons.person_2_outlined, false, _emailTextController),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Password",
                ),
                //  Icons.lock_outline, true,
                //     _passwordTextController),
              ],
            )),
      ),
    );
  }
}
