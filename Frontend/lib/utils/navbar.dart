import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorx/utils/auth.dart';

class NavBar extends StatelessWidget {
  final UserCredential userCredential;

  const NavBar({super.key, required this.userCredential});

  @override
  Widget build(BuildContext context) {
    final User? user = userCredential.user;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            accountName: Text(
              '${user?.email}',
              style: TextStyle(
                  fontSize: 23,
                  fontFamily: 'JakartaSans',
                  fontWeight: FontWeight.w700),
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
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            },
          )
        ],
      ),
    );
  }
}
