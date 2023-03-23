import 'package:appointment/screens/userScreens/appointmentfinaldetailsscreen.dart';
import 'package:appointment/services/appointmentservices.dart';
import 'package:appointment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class placeAppointment extends StatefulWidget {
  final scheduledata;
  final doctordata;
  final date;
  const placeAppointment(
      {super.key,
      required this.scheduledata,
      required this.doctordata,
      required this.date});

  @override
  State<placeAppointment> createState() => _placeAppointmentState();
}

class _placeAppointmentState extends State<placeAppointment> {
  var primaryColor;
  void initState() {
    super.initState();
    print("setalsd date ${widget.date}");
    print("setalsd doctordata ${widget.doctordata}");
    print("setalsd scheduledata${widget.scheduledata}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            'Make Appointment',
            style: GoogleFonts.urbanist(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.1,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Appointment Details',
              style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Doctor Name:   ${widget.doctordata['name']}',
                    style: GoogleFonts.urbanist(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Appointment Date:   ${DateFormat('dd/mm/yyyy').format(widget.date)}',
                    style: GoogleFonts.urbanist(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Doctor Specialization:   ${widget.doctordata['specialization']}',
                    style: GoogleFonts.urbanist(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Doctot Arival Time:   ${widget.scheduledata['arivaltime']}',
                    style: GoogleFonts.urbanist(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Doctot Leaving Time:   ${widget.scheduledata['leavingtime']}',
                    style: GoogleFonts.urbanist(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 64,
            width: MediaQuery.of(context).size.width * 1,
            padding: const EdgeInsets.only(bottom: 4),
            alignment: Alignment.center,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () async {
                        final res = await AppointmentService()
                            .addappointment(date: widget.date.toString(), docid: widget.doctordata['docid']);
                        Map<String, dynamic> resMap =
                            res as Map<String, dynamic>;
                        print('outputsa ${resMap['msg']}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(resMap["msg"]),
                            backgroundColor: Colors.black,
                            duration: Duration(seconds: 3),
                          ),
                        );
                        if (resMap['msg'] == 'Placed Appointment') {
                          print('outputsa ${resMap['Aid']}');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AppointmentDetailsScreen(
                                          Aid: resMap['Aid'])));
                        }
                      },
                      child: Text(
                        'Make Appointment',
                        style: GoogleFonts.urbanist(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
//Text(' appointment on  for ${DateFormat('dd/mm/yyyy').format(widget.date)}'),