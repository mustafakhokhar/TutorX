import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tutorx/screens/student/student_findingatutor_loading_screen.dart';
import 'package:tutorx/widgets/online_mode.dart';
import 'package:tutorx/widgets/inperson_mode.dart';
class ModeTeaching extends StatelessWidget {
  const ModeTeaching({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                      onPressed: () {
                        /////////////////////////////////////////////////////////////////////
                        // NEW SLIDE UP FOR CHOOSING ONLINE OR IN PEFRSON
                        // handle button press here
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 10, 10, 10),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Mode of Teaching',
                                    style: TextStyle(
                                      fontFamily: 'JakartaSans',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                  SizedBox(
                                    height: 52,
                                    child: OnlineMode(),
                                  ),
                                  SizedBox(height: 20),
                                  SizedBox(
                                    height: 52,
                                    child: InPersonMode(),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      /////////////////////////////////////////////////////////////////////
                      style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all<Size>(Size(247, 52)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFF583BE8)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Find Tutor',
                        style: TextStyle(
                          fontFamily: 'JakartaSans',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
  }
}