import 'package:flutter/material.dart';
import '../../services/auth_services.dart';
import '../authscreens/login.dart';

class adminHome extends StatefulWidget {
  const adminHome({super.key});

  @override
  State<adminHome> createState() => _adminHomeState();
}

class _adminHomeState extends State<adminHome> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          AuthServices().signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => login()));
        },
        child: Text('Admin Signout'),
      ),
    );
    ;
  }
}
