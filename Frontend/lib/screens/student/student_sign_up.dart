import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutorx/screens/student/student_homepage.dart';
import 'package:tutorx/utils/colors.dart';
import '../../welcome_screen.dart';

class StudentSignUpScreen extends StatefulWidget {
  const StudentSignUpScreen({Key? key}) : super(key: key);

  @override
  _StudentSignUpScreenState createState() => _StudentSignUpScreenState();
}

class _StudentSignUpScreenState extends State<StudentSignUpScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _fullnameTextController = TextEditingController();
  TextEditingController _phonenumberTextController = TextEditingController();
  TextEditingController _educationlevelTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("583BE8"),
          hexStringToColor("312181"),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Padding(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 85,
                ),
                Text(
                  "Sign up",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF2FF53)),
                ),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Full Name", Icons.person_2_outlined, false,
                    _fullnameTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Password", Icons.lock_outline, true,
                    _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Phone Number", Icons.person_2_outlined,
                    false, _phonenumberTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Email", Icons.person_2_outlined, false,
                    _emailTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Education Level", Icons.person_2_outlined,
                    false, _educationlevelTextController),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () => _signup(),
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
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to login screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WelcomeScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Already have an account? Sign In",
                    style: TextStyle(fontSize: 14),
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
            )),
      ),
    );
  }

void _signup() async {
  print("CALLED");
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailTextController.text.trim(),
      password: _passwordTextController.text.trim(),
    );

    // If the sign up is successful, navigate to the next screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StudentHomepage(
          userCredential: userCredential,
        ),
      ),
    );
  } on FirebaseAuthException catch (e) {
    print(e);
    String errorMessage;
    if (e.code == 'weak-password') {
      errorMessage = 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      errorMessage = 'The account already exists for that email.';
    } else {
      errorMessage = e.message ?? 'An error occurred while signing up.';
    }
    // Show error message on screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage),
          backgroundColor: Colors.red,
      ),
    );
  } catch (e) {
    print(e);
    // Show error message on screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred while signing up.')),
    );
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
// Test Test