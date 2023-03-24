// ignore_for_file: sort_child_properties_last

import 'package:appointment/utils/colors.dart';
import 'package:appointment/widgets/ScheduleFormModal.dart';
import 'package:appointment/widgets/common/searchabledropdown.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common/tex_field_field.dart';

class selectdoctorpopup extends StatefulWidget {
  const selectdoctorpopup({super.key});

  @override
  State<selectdoctorpopup> createState() => _selectdoctorpopupState();
}

class _selectdoctorpopupState extends State<selectdoctorpopup> {
  List<String> items = ['None', 'addss', 'das', 'das' 'das' 'das'];
  final _formKey = GlobalKey<FormState>();
  String doctor = 'None';
  final TextEditingController _doctorController = TextEditingController();

  // void doctorselctednext() async {
  //   print('fdsfjdslkfksd');

  // }
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Expanded(
                    child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )),
                onTap: () {
                   Navigator.of(context).pop();
                },
                )
                ,
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SearchableDropDownField(
                          label: 'Doctor ${doctor}',
                          hintText: 'Search Doctor',
                          withAsterisk: true,
                          selectValue: doctor,
                          items: items,
                          onChanged: (String? value) {
                            print('dsadasd ${value}');
                            setState(() {
                              doctor = value!;
                            });
                          },
                          isPass: false, 
                          doctorController: _doctorController,
                        ),
                      ],
                    )),
                SizedBox(height: 5,),
                ElevatedButton(
                  child: Text(
                    "NEXT".toUpperCase(),
                    style: GoogleFonts.urbanist(
                      fontSize: 15,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(
                        Size(200, 50),
                      ),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(color: primaryColor)))),
                  onPressed: () {
                    final isFormValid = _formKey.currentState!.validate();
                    if (isFormValid == false) {
                      return;
                    }
                    //TODO: add method to check if entered value exists in Items
                    print('[[][][][]] ${_doctorController.text}');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ScheduleManagmentModal(doctor: _doctorController.text),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
