import 'package:flutter/material.dart';
import 'package:tutorx/screens/common/first_screen.dart';
import 'package:tutorx/screens/common/settings.dart';
import 'package:tutorx/utils/auth.dart';
import 'package:tutorx/utils/shared_preferences_utils.dart';
import 'package:tutorx/screens/common/my_account.dart';

import '../screens/common/my_account.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {

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
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => myAccount(),
                ),
              );
            },
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
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => settings(),
                ),
              );
            },
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
              SharedPreferencesUtils.ClearUserDetailsFromCache();

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
