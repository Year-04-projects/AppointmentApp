import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/user_model.dart';
import '../../services/auth_services.dart';
import '../../utils/colors.dart';
import '../../widgets/nav_drawer.dart';

class ScheduleManagment extends StatefulWidget {
  const ScheduleManagment({super.key});

  @override
  State<ScheduleManagment> createState() => SscheduleManagmentState();
}

class SscheduleManagmentState extends State<ScheduleManagment> {
    User? _user;
  //get logged user details
  void userdetails() async {
    User user = await AuthServices().getUserDetails();
    print('name');
    print(user);
    setState(() {
      _user = user;
    });
  }

  @override
  void initState() {
    super.initState();
    userdetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text(
          'Admin Home',
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.1,
          ),
        ),
      ),
      drawer: NavDrawer(),
    );;
  }
}