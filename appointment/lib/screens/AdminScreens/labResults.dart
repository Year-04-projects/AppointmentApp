import 'package:appointment/screens/AdminScreens/LabTests.dart';
import 'package:appointment/screens/AdminScreens/addLabResult.dart';
import 'package:appointment/screens/AdminScreens/adminhome.dart';
import 'package:appointment/screens/AdminScreens/allLabResults.dart';
import 'package:appointment/screens/AdminScreens/schedulemanagment.dart';
import 'package:appointment/screens/AdminScreens/updateschedulescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/user_model.dart';
import '../../services/auth_services.dart';
import '../../utils/colors.dart';
import '../../widgets/nav_drawer.dart';

class LabResults extends StatefulWidget {
  const LabResults({super.key});

  @override
  State<LabResults> createState() => _LabResultsState();
}

class _LabResultsState extends State<LabResults> {
  int _labWidgetIndex = 0;
  final screens = [
    AllLabResults(),
    AddLabResult(),
    LabTests(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: primaryColor,
            title: Text(
              'Lab Results',
              style: GoogleFonts.urbanist(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.1,
              ),
            )),
        body: Center(
          child: screens[_labWidgetIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _labWidgetIndex,
            onTap: (int newIndex) {
              setState(() {
                _labWidgetIndex = newIndex;
              });
            },
            items: const [
              BottomNavigationBarItem(
                label: 'Lab Results',
                icon: Icon(Icons.list),
              ),
              BottomNavigationBarItem(
                label: 'Add Result',
                icon: Icon(Icons.addchart),
              ),
              BottomNavigationBarItem(
                label: 'Lab Tests',
                icon: Icon(Icons.health_and_safety),
              ),
            ]),
      ),
    );
  }
}
