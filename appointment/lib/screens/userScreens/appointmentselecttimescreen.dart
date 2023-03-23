import 'dart:ffi';

import 'package:appointment/screens/userScreens/placeappointmentscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../utils/colors.dart';

class appointmenttime extends StatefulWidget {
  final docid;
  const appointmenttime({super.key, required this.docid});

  @override
  State<appointmenttime> createState() => _appointmenttimeState();
}

class _appointmenttimeState extends State<appointmenttime> {
  bool _isLoading = false;
  var _Data;
  var _SchduleData;
  List<DateTime> days =
      List.generate(7, (index) => DateTime.now().add(Duration(days: index)));

  List<String> selectedDays = [];

  void initState() {
    super.initState();
    getdoc();
  }

  getdoc() async {
    setState(() {
      _isLoading = true;
    });
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('doctors');
    QuerySnapshot querySnapshot =
        await _collectionRef.where('docid', isEqualTo: widget.docid).get();

    CollectionReference _schedulecollectionRef =
        FirebaseFirestore.instance.collection('schedule');
    QuerySnapshot schedulequerySnapshot = await _schedulecollectionRef
        .where('docid', isEqualTo: widget.docid)
        .get();
    _SchduleData = schedulequerySnapshot.docs.map((doc) => doc.data()).toList();
    _Data = querySnapshot.docs.map((doc) => doc.data()).toList();

    print('data is${_SchduleData[0]['daysavailable']}');
    _SchduleData[0]['daysavailable'].forEach((e) => selectedDays.add(e));
    setState(() {
      _Data = _Data[0];
    });
    setState(() {
      _SchduleData = _SchduleData[0];
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            'Select Day',
            style: GoogleFonts.urbanist(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.1,
            ),
          ),
        ),
        body: _isLoading
            ? Text('loading')
            : SingleChildScrollView(
                child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Doctor Name: ${_Data['name']}',
                      style: GoogleFonts.urbanist(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Select A day for appointment',
                      style: GoogleFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [],
                    ),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        for (DateTime day in days)
                          selectedDays.contains(
                                  DateFormat('EEE').format(day).toString())
                              ? GestureDetector(
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    color: primaryColor,
                                    child: Column(children: [
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        DateFormat('EEE').format(day),
                                        style: GoogleFonts.urbanist(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: -0.1,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        DateFormat('dd').format(day),
                                        style: GoogleFonts.urbanist(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: -0.1,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ]),
                                  ),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                placeAppointment(
                                                    scheduledata: _SchduleData,
                                                    doctordata: _Data,
                                                    date: day)));
                                  },
                                )
                              : Text('')
                      ],
                    )
                  ],
                ),
              )));
    ;
  }
}
