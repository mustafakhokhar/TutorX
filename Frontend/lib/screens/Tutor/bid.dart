import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tutorx/models/bids_model.dart';
import 'package:tutorx/utils/base_client.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';

class BidScreen extends StatefulWidget {
  @override
  _BidScreenState createState() => _BidScreenState();
}

class _BidScreenState extends State<BidScreen> {
  final TextEditingController _bidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // return Scaffold(

    //   body: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           'Enter Bid',
    //           style: TextStyle(
    //             fontSize: 16.0,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         SizedBox(height: 10.0),
    //         TextFormField(
    //           controller: _bidController,
    //           keyboardType: TextInputType.number,
    //           decoration: InputDecoration(
    //             border: OutlineInputBorder(),
    //             hintText: 'Enter your bid amount',
    //           ),
    //         ),
    //         SizedBox(height: 10.0),
    //         ElevatedButton(
    //           onPressed: () {
    //             // Implement your button logic here
    //             print('Bid submitted: ${_bidController.text}');
    //           },
    //           child: Text('Submit Bid'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      // backgroundColor: Colors.black87,
      backgroundColor: Color.fromARGB(255, 5, 5, 5).withOpacity(0.5),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.4),
            Text(
              'Enter the amount',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _bidController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your bid amount',
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            SizedBox(height: 10.0),
            // ElevatedButton(
            //   onPressed: () {
            //     // Implement your button logic here
            //     print('Bid submitted: ${_bidController.text}');
            //   },
            //   child: Text('Submit Bid'),
            // ),
            ElevatedButton(
              child: Text('Bid',
                  style: TextStyle(
                      fontFamily: 'JakartaSans',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 255, 255, 255))),
              onPressed: () async {
                print('Bid submitted: ${_bidController.text}');
                var uid = await SharedPreferencesUtils.getUID();
                var bid_obj = Bids(
                  studentId: uid,
                  tutorId: '',
                  bidAmount: int.parse(_bidController.text),
                );
                final response =
                    await BaseClient().get("/bids/${uid}").catchError((err) {});

                // print(response);
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(Size(130, 45)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF583BE8)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          // String uid = await SharedPreferencesUtils.getUID();
          //           var response = await BaseClient()
          //               .delete("/activeTutors/${uid}")
          //               .catchError((err) {
          //             print(err);
          //           });
          // if (response!= null) {

          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         // StudentFindingTutorLoadingScreen(),
          //         TutorHomepage(),
          //   ),
          // );
          // }
        },
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 3, color: Colors.white),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(
          Icons.arrow_back,
          size: 32,
          color: Colors.white,
        ), // add the hamburger menu icon here
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      // backgroundColor: Colors.black,
    );
  }

  @override
  void dispose() {
    _bidController.dispose();
    super.dispose();
  }
}
