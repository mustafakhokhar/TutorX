import 'package:tutorx/screens/student/student_sign_up.dart';
import 'package:tutorx/sign_in_options_screen.dart';
import 'package:tutorx/screens/student/student_login.dart';

var appRoutes = {
  '/signInOptions': (context) => WelcomeScreen(),
  // '/askingScreen': (context) => AskingPage(),
  '/studentSignUpScreen': (context) => StudentSignUpScreen(),
  // '/studentHomeScreen': (context) => StudentHomepage(userCredential: ,),
  '/studentSignIn': (context) => StudentSignIn(),
  // '/mapScreen': (context) => MapScreen(userCredential: null,),
};
