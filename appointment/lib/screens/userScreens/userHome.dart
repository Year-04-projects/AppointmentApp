
import 'package:appointment/widgets/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/auth_services.dart';
import '../../utils/colors.dart';
import '../authscreens/login.dart';

class userHome extends StatefulWidget {
  const userHome({Key? key}) : super(key: key);

  @override
  State<userHome> createState() => _userHomeState();
}

class _userHomeState extends State<userHome> {
  int _currentIndex = 0;
  void onTabTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

//add screen widgets here
final List<Widget> _children = [
  Center(child: Text('Home screen')),
  Center(child: Text('2rd Screen')),
  profilescreen()
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: secondaryColor,
          title: Row(
            children: [
              Image.asset(
                'assets/logo.png',
                width: 48,
              ),
              SizedBox(width: 10),
              Text(
                'Medicare',
                style: GoogleFonts.urbanist(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.1,
                    color: primaryColor),
              ),
            ],
          )),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.outlet_sharp),
            label: 'Other',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
