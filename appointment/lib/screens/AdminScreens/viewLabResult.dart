import 'package:appointment/screens/root_screen.dart';
import 'package:appointment/services/resultServices.dart';
import 'package:appointment/utils/colors.dart';
import 'package:appointment/widgets/common/dateinputfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/user_model.dart';
import 'package:appointment/models/results_model.dart';
import '../../services/auth_services.dart';
import '../../widgets/nav_drawer.dart';
import '../authscreens/login.dart';
import 'LabResults.dart';

class ViewResult extends StatefulWidget {
  final Result? result;
  ViewResult({this.result});

  @override
  State<ViewResult> createState() => _ViewResultState();
}

class _ViewResultState extends State<ViewResult> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String testType = widget.result!.dropdownValue.toString();
    String testedBy = widget.result!.name.toString();
    String age = widget.result!.age.toString();
    String patientName = widget.result!.patientName.toString();
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: secondaryColor),
      home: Scaffold(
          body: Center(
        child: Container(
          color: Colors.transparent,
          constraints: const BoxConstraints(
            maxWidth: 600,
            maxHeight: 350,
          ),
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 8,
                  ),
                  Title(
                    color: primaryColor,
                    child: Text(
                      '$patientName | $testType',
                      style: GoogleFonts.urbanist(
                          fontSize: 28,
                          color: primaryColor,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  // ignore: prefer_interpolation_to_compose_strings
                  Text(
                    "Patient name : $patientName",
                    style: GoogleFonts.inter(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Patient age : $age",
                    style: GoogleFonts.inter(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Test Type : $testType",
                    style: GoogleFonts.inter(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Tested By : $testedBy",
                    style: GoogleFonts.inter(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                maintainState: true,
                                builder: (context) => const LabResults()),
                          );
                        },
                        icon: const Icon(Icons.home),
                        label: const Text('Go Back To Home Page'),
                        style: TextButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                            textStyle: const TextStyle(fontSize: 22)),
                      )
                    ],
                  )
                  // ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  InputDecoration decoration(String label) =>
      InputDecoration(labelText: label, border: const OutlineInputBorder());
}
