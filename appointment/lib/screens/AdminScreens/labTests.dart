import 'package:appointment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/user_model.dart';
import '../../services/auth_services.dart';
import '../../widgets/nav_drawer.dart';
import '../authscreens/login.dart';

class LabTests extends StatefulWidget {
  const LabTests({super.key});

  @override
  State<LabTests> createState() => _LabTestsState();
}

class _LabTestsState extends State<LabTests> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
        title: const Text('All Lab Tests'),
      )),
    );
  }
}
