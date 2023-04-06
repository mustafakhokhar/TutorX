import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorx/screens/common/first_screen.dart';
import 'package:tutorx/utils/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';

class NavBar extends StatelessWidget {


  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    Future<void> ClearUserDetailsFromCache() async {
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fullname', '');
      await prefs.setString('uid', '');
      await prefs.setBool('student', false);
      await prefs.setBool('isLoggedIn', false);
    }
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            accountName: FutureBuilder<String>(
              future: SharedPreferencesUtils.getUserName(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!,
                    style: TextStyle(
                      fontSize: 23,
                      fontFamily: 'JakartaSans',
                      fontWeight: FontWeight.w700,
                    ),
                  );
                } else {
                  return Text('');
                }
              },
            ),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                  child: Image.network(
                'https://pbs.twimg.com/media/B5uu_b4CEAEJknA?format=jpg&name=medium',
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              )),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'My account',
              style: TextStyle(
                  fontFamily: 'JakartaSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            iconColor: Color(0xFFF2FF53),
            textColor: Colors.white,
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text(
              'History',
              style: TextStyle(
                  fontFamily: 'JakartaSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            iconColor: Color(0xFFF2FF53),
            textColor: Colors.white,
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.help_center),
            title: Text(
              'Help Center',
              style: TextStyle(
                  fontFamily: 'JakartaSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            iconColor: Color(0xFFF2FF53),
            textColor: Colors.white,
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                  fontFamily: 'JakartaSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            iconColor: Color(0xFFF2FF53),
            textColor: Colors.white,
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Sign Out',
              style: TextStyle(
                  fontFamily: 'JakartaSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            iconColor: Color(0xFFF2FF53),
            textColor: Colors.white,
            onTap: () async {
              await Authentication.signOut(context: context);
              // Navigator.of(context).pushNamedAndRemoveUntil(
              //     '/', (Route<dynamic> route) => false);
              ClearUserDetailsFromCache();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FirstScreen(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
