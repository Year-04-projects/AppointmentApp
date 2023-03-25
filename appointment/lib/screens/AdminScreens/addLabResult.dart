import 'package:appointment/screens/AdminScreens/AllLabResults.dart';
import 'package:appointment/services/resultServices.dart';
import 'package:appointment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/user_model.dart';
import '../../services/auth_services.dart';
import '../../widgets/nav_drawer.dart';
import '../authscreens/login.dart';

class AddLabResult extends StatefulWidget {
  const AddLabResult({super.key});

  @override
  State<AddLabResult> createState() => _AddLabResultState();
}

class _AddLabResultState extends State<AddLabResult> {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerAge = TextEditingController();
  final TextEditingController controllerPatientName = TextEditingController();
  // final TextEditingController dropdownValue = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'ECG';
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
          body: Center(
        child: Form(
            key: _formKey,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  const SizedBox(
                    height: 24,
                  ),
                  Title(
                    color: primaryColor,
                    child: Text(
                      'Add New Lab Result',
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
                  TextFormField(
                    decoration:
                        decoration(true, secondaryColor, 'Patient name'),
                    keyboardType: TextInputType.text,
                    controller: controllerPatientName,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "this field is required";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    decoration: decoration(true, secondaryColor, 'Age'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "this field is required";
                      }
                    },
                    controller: controllerAge,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    decoration:
                        decoration(true, secondaryColor, 'Tested By Name'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "this field is required";
                      }
                    },
                    controller: controllerName,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  DropdownButtonFormField(
                    decoration: decoration(true, secondaryColor, 'Test type'),
                    value: dropdownValue,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "this field is required";
                      }
                    },
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Blood report', 'ECG', 'EEG', 'Ultra sound']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 15),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var response = await ResultService.addResult(
                          name: controllerName.text,
                          age: int.parse(controllerAge.text),
                          patientName: controllerPatientName.text,
                          dropdownValue: dropdownValue,
                        );
                        if (response.code != 200) {
                          // ignore: use_build_context_synchronously
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(response.message.toString()),
                                );
                              });
                        } else {
                          // ignore: use_build_context_synchronously
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(response.message.toString()),
                                );
                              });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                maintainState: true,
                                builder: (context) => const AllLabResults()),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      primary: primaryColor,
                    ),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            )),
      )),
    );
  }

  InputDecoration decoration(filled, fillColor, String label) =>
      InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 22),
        border: const OutlineInputBorder(),
        fillColor: secondaryColor,
        filled: true,
      );
}
