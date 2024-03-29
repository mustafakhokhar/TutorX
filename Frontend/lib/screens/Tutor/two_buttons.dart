import 'dart:ffi';

import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  const MyButton(teaching_mode, {Key? key}) : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isOnline = true;
  bool _isInPerson = false;
  var teaching_mode = 0; // 0 used for in person

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isOnline = true;
              _isInPerson = false;
              print('Tutor is ready for Online Tuition');
              teaching_mode = 1; // 1 for online
            });
          },
          child: Container(
            width: 162,
            height: 59,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _isOnline ? Color(0xFFF2FF53) : Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              'Online',
              style: TextStyle(
                color: _isOnline ? Colors.black : Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'JakartaSans',
              ),
            ),
          ),
        ),
        SizedBox(
          width: 17,
        ),
        InkWell(
          onTap: () {
            setState(() {
              _isOnline = false;
              _isInPerson = true;
              print('Tutor is ready for Offline Tuition');
              teaching_mode = 0;
            });
          },
          child: Container(
            width: 162,
            height: 59,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _isInPerson ? Color(0xFFF2FF53) : Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              'In-Person',
              style: TextStyle(
                color: _isInPerson ? Colors.black : Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'JakartaSans',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
