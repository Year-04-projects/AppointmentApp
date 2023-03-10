
import 'package:flutter/material.dart';

import '../../services/auth_services.dart';
import '../authscreens/login.dart';

class userHome extends StatefulWidget {
  const userHome({super.key});

  @override
  State<userHome> createState() => _userHomeState();
}

class _userHomeState extends State<userHome> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          AuthServices().signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => login()));
        },
        child: Text('userSignout'),
      ),
    );
    ;
  }
}
