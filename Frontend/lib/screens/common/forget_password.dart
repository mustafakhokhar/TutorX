import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text,
        );

        setState(() {
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password reset email sent!'),
            ),
          );
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message!),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:tutorx/utils/colors.dart';

// class ForgetPasswordScreen extends StatefulWidget {
//   @override
//   _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
// }

// class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   bool _isLoading = false;

  
// // void _submitForm() async {
// //   print("Called");
// //   if (_formKey.currentState!.validate()) {
// //     setState(() {
// //       _isLoading = true;
// //     });

// //     try {
// //       await FirebaseAuth.instance.sendPasswordResetEmail(
// //         email: _emailController.text,
// //       );

// //       await ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Password reset email sent!'),
// //         ),
// //       );

// //       setState(() {
// //         _isLoading = false;
// //       });
// //     } on FirebaseAuthException catch (e) {
// //       setState(() {
// //         _isLoading = false;
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text(e.message!),
// //           ),
// //         );
// //       });
// //     } catch (e) {
// //       setState(() {
// //         _isLoading = false;
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(
// //             content: Text('An unexpected error occurred.'),
// //           ),
// //         );
// //       });
// //     }
// //   }
// // }

// void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });

//       try {
//         await FirebaseAuth.instance.sendPasswordResetEmail(
//           email: _emailController.text,
//         );

//         setState(() {
//           _isLoading = false;
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Password reset email sent!'),
//             ),
//           );
//         });
//       } on FirebaseAuthException catch (e) {
//         setState(() {
//           _isLoading = false;
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(e.message!),
//             ),
//           );
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               hexStringToColor("583BE8"),
//               hexStringToColor("312181"),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(
//               50, MediaQuery.of(context).size.height * 0.2, 50, 0),
//           child: Column(
//             children: <Widget>[
//               Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.arrow_back),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     color: Color(0xFFF2FF53),
                    
                    
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Text(
//                     "Forget Password",
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFFF2FF53),
                      
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 80,
//               ),
//               Text(
//                 "Please enter your email",
//                 style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFFF2FF53),
                  
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               reusableTextField("Email",
//                   Icons.person_2_outlined, false, _emailController),
              
//               SizedBox(
//                 height: 40,
//               ),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _submitForm,
//                 child: _isLoading
//                     ? CircularProgressIndicator()
//                     : Text(
//                         "Submit",
//                         style: TextStyle(fontSize: 16),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         primary: Color(0xFFF2FF53),
                        
//                         onPrimary: Colors.black,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         padding:
//                             EdgeInsets.symmetric(vertical: 15, horizontal: 50),
//                       ),
//                     ),
//               SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }


// }



// TextField reusableTextField(String text, IconData icon, bool isPasswordType,
//     TextEditingController controller) {
//   return TextField(
//     controller: controller,
//     obscureText: isPasswordType,
//     enableSuggestions: !isPasswordType,
//     autocorrect: !isPasswordType,
//     cursorColor: Color.fromARGB(255, 0, 0, 0),
//     style: TextStyle(
//         color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
//     decoration: InputDecoration(
//       prefixIcon: Icon(
//         icon,
//         color: Color.fromARGB(255, 8, 8, 8),
//       ),
//       labelText: text,
//       labelStyle: TextStyle(
//           color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
//       filled: true,
//       floatingLabelBehavior: FloatingLabelBehavior.never,
//       fillColor: Colors.white,
//       border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30.0),
//           borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
//     ),
//     keyboardType: isPasswordType
//         ? TextInputType.visiblePassword
//         : TextInputType.emailAddress,
//   );
// }
