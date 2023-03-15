import 'package:flutter/material.dart';

import '../screens/authscreens/login.dart';
import '../services/auth_services.dart';

class profilescreen extends StatefulWidget {
  const profilescreen({super.key});

  @override
  State<profilescreen> createState() => _profilescreenState();
}

class _profilescreenState extends State<profilescreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          AuthServices().signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => login()));
        },
        child: Text('User Signout'),
      ),
    );
  }
}
