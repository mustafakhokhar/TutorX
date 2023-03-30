import 'package:flutter/material.dart';
import 'package:tutorx/screens/student/find_tutor_screen.dart';
import 'package:tutorx/screens/student/find_tutor_screen_online.dart';

class ModeOfTeachingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 60,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
            color: Color.fromRGBO(146, 137, 137, 0.8),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Mode of Teaching',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FindTutorScreen(),
                    ),
                  );
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(250, 52)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFF2FF53)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
                child: Text(
                  'In-person',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FindTutorScreenOnline(),
                    ),
                  );
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(250, 52)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFF2FF53)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
                child: Text(
                  'Online',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
