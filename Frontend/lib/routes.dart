import 'package:google_sign_in/google_sign_in.dart';
import 'package:tutorx/screens/common/log_in.dart';
import 'package:tutorx/screens/student/student_sign_up.dart';
import 'package:tutorx/welcome_screen.dart';

var appRoutes = {
  '/': (context) => WelcomeScreen(),
  '/studentSignIn': (context) => LoginPage(),
  '/studentGoogleSignIn': (context) => GoogleSignIn(),
  '/studentSignUp': (context) => StudentSignUpScreen(),
  // '/forgot-password': (context) => ForgotPasswordScreen(),
  // Navigator.pushNamed(context, '/dashboard');
};
