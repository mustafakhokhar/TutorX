import 'package:flutter/material.dart';
import 'package:tutorx/models/pending_tuitions_model.dart';
import 'package:tutorx/screens/student/student_findingatutor_loading_screen.dart';
import 'package:tutorx/utils/base_client.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';

class OnlineMode extends StatelessWidget {
  // const OnlineMode({super.key});
  final _centre;
  const OnlineMode(this._centre, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String topic = '';
    String subject = '';
    return ElevatedButton(
      onPressed: () {
        // Put ROUTE FOR ONLINE here
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30.0),
            ),
          ),
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 10, 10, 10),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 40),
                    Center(
                      child: Text(
                        'Online Tuition',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontFamily: 'JakartaSans',
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    DropdownButtonFormField<String>(
                      items: [
                        DropdownMenuItem(
                            child: Text(
                              "Choose your subject",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            value: ''),
                        // Add more subjects here
                        DropdownMenuItem(
                            child: Text(
                              "Math",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            value: 'Math'),
                        DropdownMenuItem(
                            child: Text(
                              "Science",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            value: 'Science'),
                      ],
                      onChanged: (value) {
                        // Handle subject selection
                        subject = value!;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      hint: Text(
                        'Choose your subject',
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      dropdownColor: Colors.white,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      onChanged: (value) {
                        topic = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your topic',
                        hintStyle:
                            TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          var uid = await SharedPreferencesUtils.getUID();

                          var Tuition = PendingTuitions(
                            studentId: uid,
                            topic: topic,
                            subject: subject,
                            longitude: _centre.longitude!,
                            latitude: _centre.latitude!,
                          );

                          var response = await BaseClient().post("/pendingTuitions",Tuition).catchError((err) {});
                          // print(response.toString());

                          //LOADING SCREEN ROUTE
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  StudentFindingTutorLoadingScreen(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          fixedSize:
                              MaterialStateProperty.all<Size>(Size(246, 59)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFF2FF53)),
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
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(Size(246, 59)),
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF2FF53)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      child: Text(
        'Online',
        style: TextStyle(
            fontFamily: 'JakartaSans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 0, 0, 0)),
      ),
    );
  }
}
