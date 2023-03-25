// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:appointment/screens/AdminScreens/adminhome.dart';
import 'package:appointment/screens/AdminScreens/schedulemanagment.dart';
import 'package:appointment/services/schedule.service.dart';
import 'package:appointment/widgets/common/Iconbtn.dart';
import 'package:appointment/widgets/common/dateinputfield.dart';
import 'package:appointment/widgets/common/dropdownfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';
import 'common/tex_field_field.dart';

class ScheduleManagmentModal extends StatefulWidget {
  final String doctor;
  const ScheduleManagmentModal({super.key, required this.doctor});

  @override
  State<ScheduleManagmentModal> createState() => _ScheduleManagmentModalState();
}

class _ScheduleManagmentModalState extends State<ScheduleManagmentModal> {
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _patientcountController = TextEditingController();
  final TextEditingController _commentcontroller = TextEditingController();
  final TextEditingController _arrivaltimecontroller = TextEditingController();
  final TextEditingController _leavingtimecontroller = TextEditingController();

  List<String> days = ['Mon', 'Tue', 'Wens', 'Thur', 'Frid', 'Sat', 'Sun'];
  List<String> selectedDays = [];

  void addschedule() async {
    final isFormValid = _formKey.currentState!.validate();
    if (isFormValid == false && selectedDays.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Empty Fields'),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('doctors');
    QuerySnapshot querySnapshot =
        await _collectionRef.where('name', isEqualTo: widget.doctor).get();
    var _Data = querySnapshot.docs.map((doc) => doc.data()).toList();
    var doctorid = (_Data?[0] as Map<String, dynamic>)?["uid"];
    print('doctoreid ${(_Data?[0] as Map<String, dynamic>)?["uid"]}');
    final count = int.tryParse(_patientcountController.text);

    String res = await ScheduleService().addschedule(
        arivaltime: _arrivaltimecontroller.text,
        leavingtime: _leavingtimecontroller.text,
        patientcount: count!,
        venue: _venueController.text,
        daysavailable: selectedDays,
        comment: _commentcontroller.text,
        docid: doctorid);
    print('dfsfgdsgdf ${res}');
    if (res == 'Added Schedule') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 3),
        ),
      );
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ScheduleManagment()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    //check view
    final isTablet = MediaQuery.of(context).size.width > 600;
    final inputPadding = const EdgeInsets.symmetric(vertical: 8.0);
    final inputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: progressBackgroundColor),
      borderRadius: BorderRadius.circular(12),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text(
          'Schedule for ${widget.doctor.length > 15 ? widget.doctor.substring(0, 15) : widget.doctor}',
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.1,
          ),
        ),
        actions: [
          Icontbtn(
            onPressed: () {},
            icons: Icons.not_interested,
          ),
          SizedBox(
            width: 10,
          ),
          Icontbtn(
            onPressed: (() => addschedule()),
            icons: Icons.save,
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
      body: SafeArea(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity,
              child: CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      child: Column(
                                    children: [
                                      dateInputfield(
                                        controller: _arrivaltimecontroller,
                                        label: 'Arribval Time',
                                        hintText: 'Select Doctor Arrival Time',
                                        withAsterisk: true,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFieldInput(
                                        textEditingController:
                                            _patientcountController,
                                        label: 'Patient Count',
                                        hintText:
                                            'Number of patients for schedule.',
                                        textInputType: TextInputType.datetime,
                                        textInputAction: TextInputAction.next,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  )),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    child: Center(
                                      child: Column(
                                        children: [
                                          dateInputfield(
                                            controller: _leavingtimecontroller,
                                            label: 'Leaving Time',
                                            hintText:
                                                'Select Doctor Leaving Time',
                                            withAsterisk: true,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFieldInput(
                                            textEditingController:
                                                _venueController,
                                            label: 'Venue',
                                            hintText: 'Doctor Appointment Room',
                                            textInputType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.next,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              'Select Days of Appointment',
                              style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // color: Colors.amberAccent,
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: days.map((day) {
                                      final isSelected =
                                          selectedDays.contains(day);

                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (isSelected) {
                                              selectedDays.remove(day);
                                            } else {
                                              selectedDays.add(day);
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.129,
                                          margin: EdgeInsets.all(4),
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color:
                                                  Color.fromARGB(81, 0, 0, 0),
                                              width: 1,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(
                                                    isSelected ? 0 : 0.3),
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: isSelected
                                                ? primaryColor
                                                : secondaryColor,
                                          ),
                                          child: Text(
                                            day,
                                            style: GoogleFonts.urbanist(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: -0.1,
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Comment (Optional)',
                                style: GoogleFonts.urbanist(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _commentcontroller,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      hintText: 'Any Comment',
                                      border: inputBorder,
                                      focusedBorder: inputBorder,
                                      enabledBorder: inputBorder,
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: redIconColor),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 14),
                                    ),
                                    style: GoogleFonts.urbanist(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ))
                  ]))
                ],
              ))),
    );
  }
}

// Column(children: [
                          // DropDownField(
                          //   label: 'Doctor',
                          //   hintText: 'Select Doctor',
                          //   withAsterisk: true,
                          //   selectValue: doctor,
                          //   onChanged: (String? value) {
                          //     setState(() {
                          //       doctor = value!;
                          //     });
                          //   },
                          //   items: items,
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: DropDownField(
//                                   label: 'Venue',
//                                   hintText: 'Select Venu',
//                                   withAsterisk: true,
//                                   selectValue: venue,
//                                   onChanged: (String? value) {
//                                     setState(() {
//                                       venue = value!;
//                                     });
//                                   },
//                                   items: items,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Expanded(
//                                 child: TextFieldInput(
//                                   textEditingController: _nameController,
//                                   label: 'Pricing',
//                                   hintText: 'Enter doctor appointment price',
//                                   textInputType: TextInputType.number,
//                                   textInputAction: TextInputAction.next,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),

                          // dateInputfield(
                          //   controller: _dateController,
                          //   label: 'Arribval Time',
                          //   hintText: 'Select Doctor Arrival Time',
                          //   withAsterisk: true,
                          // ),

//                           // Row(
//                           //   children: [

//                           //   ],
//                           // )
                        
//                         ]
                        
//                         )