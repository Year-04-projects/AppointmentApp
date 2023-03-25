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

class EditResult extends StatefulWidget {
  final Result? result;
  EditResult({this.result});

  @override
  State<EditResult> createState() => _EditResultState();
}

class _EditResultState extends State<EditResult> {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerAge = TextEditingController();
  final TextEditingController uid = TextEditingController();
  final TextEditingController controllerPatientName = TextEditingController();
  final TextEditingController dropdownValue = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    uid.value = TextEditingValue(text: widget.result!.uid.toString());
    controllerName.value =
        TextEditingValue(text: widget.result!.name.toString());
    controllerAge.value = TextEditingValue(text: widget.result!.age.toString());
    controllerPatientName.value =
        TextEditingValue(text: widget.result!.patientName.toString());
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'ECG';
    return Scaffold(
        body: Center(
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
                'Edit Result',
                style: GoogleFonts.urbanist(
                    fontSize: 20,
                    color: primaryColor,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            TextField(
              decoration: decoration(true, Colors.white, 'ID'),
              keyboardType: TextInputType.text,
              readOnly: true,
              controller: uid,
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              decoration: decoration(true, Colors.white, 'Patient Name'),
              keyboardType: TextInputType.text,
              controller: controllerPatientName,
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              decoration: decoration(true, Colors.white, 'Age'),
              keyboardType: TextInputType.number,
              controller: controllerAge,
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              decoration: decoration(true, Colors.white, 'Tested By'),
              keyboardType: TextInputType.text,
              controller: controllerName,
            ),
            const SizedBox(
              height: 24,
            ),
            DropdownButtonFormField(
              decoration: decoration(true, Colors.white, 'Test type'),
              value: dropdownValue,
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
                var response = await ResultService.updateLabResult(
                  id: uid.text,
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
                        builder: (context) => const LabResults()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                primary: primaryColor,
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    ));
  }

  InputDecoration decoration(filled, fillColor, String label) =>
      InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        labelStyle: const TextStyle(fontSize: 22),
        fillColor: secondaryColor,
        filled: true,
      );
}
