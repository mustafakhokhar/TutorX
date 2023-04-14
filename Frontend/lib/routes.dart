import 'package:tutorx/screens/common/first_screen.dart';
import 'package:tutorx/screens/student/student_sign_up.dart';
// import 'package:tutorx/sign_in_options_screen.dart';
import 'package:tutorx/screens/student/student_login.dart';
import 'package:tutorx/screens/student/student_homepage.dart';

var appRoutes = {
  // '/signInOptions': (context) => WelcomeScreen(),
  // '/askingScreen': (context) => AskingPage(),
  '/studentSignUpScreen': (context) => StudentSignUpScreen(),
  '/studentHomeScreen': (context) => StudentHompage(),
  '/studentSignIn': (context) => StudentSignIn(),
  '/firstScreen': (context) => FirstScreen(),
  // '/mapScreen': (context) => MapScreen(userCredential: null,),
};
                // Navigator.pushNamed(context, '/studentSignUpScreen');
