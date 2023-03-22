import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorx/screens/student/student_homepage.dart';
import 'package:tutorx/screens/common/forget_password.dart';
import 'package:tutorx/utils/colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("583BE8"),
              hexStringToColor("312181"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              50, MediaQuery.of(context).size.height * 0.2, 50, 0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Color(0xFFF2FF53),
                    
                    
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF2FF53),
                      
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
              ),
              Text(
                "Let's Sign You In",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF2FF53),
                  
                ),
              ),
              SizedBox(
                height: 20,
              ),
              reusableTextField("Email or Phone Number",
                  Icons.person_2_outlined, false, _emailController),
              SizedBox(
                height: 20,
              ),
              reusableTextField(
                  "Password", Icons.lock_outline, true, _passwordController),
              SizedBox(
                height: 40,
              ),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () => _login(),
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFF2FF53),
                        
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                //Forgot Password button
                onPressed: () {
                  // Perform forgot password action here
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => ForgetPasswordScreen()));
                },
                child: Text(
                  "Forgot password?",
                  style: TextStyle(fontSize: 16),
                ),
                style: TextButton.styleFrom(
                  primary: Color(0xFFF2FF53),
                  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    print("CALLED");
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // If the sign in was successful, do something here
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => StudentHomepage(
            userCredential: userCredential,
          ),
        ),
      );
      print('Signed in user: ${userCredential.user!.uid}');
    } on FirebaseAuthException catch (e) {
      print('Failed to authenticate: ${e.message}');
      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else {
        errorMessage = e.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Color.fromARGB(255, 0, 0, 0),
    style: TextStyle(
        color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Color.fromARGB(255, 8, 8, 8),
      ),
      labelText: text,
      labelStyle: TextStyle(
          color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}
