import 'package:tutorx/screens/common/log_in.dart';
import 'package:tutorx/screens/student/student_sign_up.dart';
import 'package:tutorx/welcome_screen.dart';

var appRoutes = {
  '/welcomeScreen': (context) => WelcomeScreen(),
  '/studentSignIn': (context) => LoginPage(),
  '/studentSignUp': (context) => StudentSignUpScreen(),
};
