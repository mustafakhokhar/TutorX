import 'package:flutter/material.dart';

class AskingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 150),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Who are you',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 40,
                                fontFamily: 'JakartaSans',
                                color: Color(0xFFF2FF53)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      SizedBox(height: 35),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFF583BE8)),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/studentSignUpScreen');
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 32.0,
                          ),
                          child: Text(
                            'I\'m a Student',
                            style: TextStyle(
                              fontFamily: 'JakartaSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
                      Flexible(
                        flex: 1,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xFF583BE8)),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/studentSignUpScreen');
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 32.0,
                            ),
                            child: Text(
                              'I\'m a Tutor',
                              style: TextStyle(
                                fontFamily: 'JakartaSans',
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
