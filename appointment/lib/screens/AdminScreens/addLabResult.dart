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

class AddLabResult extends StatefulWidget {
  const AddLabResult({super.key});

  @override
  State<AddLabResult> createState() => _AddLabResultState();
}

class _AddLabResultState extends State<AddLabResult> {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerAge = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
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
                    fontSize: 20,
                    color: primaryColor,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              decoration: decoration('Test Name'),
              keyboardType: TextInputType.text,
              controller: controllerName,
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              decoration: decoration('text'),
              keyboardType: TextInputType.number,
              controller: controllerAge,
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () async {
                var response = await ResultService.addResult(
                  name: controllerName.text,
                  age: int.parse(controllerAge.text),
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
      )),
    );
  }

  InputDecoration decoration(String label) =>
      InputDecoration(labelText: label, border: const OutlineInputBorder());
}
