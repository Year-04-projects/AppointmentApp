import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:gallery_saver/gallery_saver.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final Aid;
  const AppointmentDetailsScreen({super.key, required this.Aid});

  @override
  State<AppointmentDetailsScreen> createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  Uint8List? bytes;

  get primaryColor => null;
  bool _isLoading = false;
  var _AppointmentNumber;
  var _Date;
  var _doctordetails;
  var _patientdetails;
  var _scheduledetails;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var collection = FirebaseFirestore.instance.collection('appointment');
      var docSnapshot = await collection.doc(widget.Aid).get();
      _AppointmentNumber = docSnapshot['appointmentnumber'].toString();
      //get doctor details
      CollectionReference _doccollectionRef =
          FirebaseFirestore.instance.collection('doctors');
      QuerySnapshot docquerySnapshot = await _doccollectionRef
          .where('uid', isEqualTo: docSnapshot['docid'])
          .get();
      //get patient details
      CollectionReference _patientcollectionRef =
          FirebaseFirestore.instance.collection('users');
      QuerySnapshot patientquerySnapshot = await _patientcollectionRef
          .where('uid', isEqualTo: docSnapshot['patientID'])
          .get();
      //schedule details
      CollectionReference _schedulecollectionRef =
          FirebaseFirestore.instance.collection('schedule');
      QuerySnapshot schedulequerySnapshot = await _schedulecollectionRef
          .where('docid', isEqualTo: docSnapshot['docid'])
          .get();
      _scheduledetails =
          schedulequerySnapshot.docs.map((doc) => doc.data()).toList();
      _patientdetails =
          patientquerySnapshot.docs.map((doc) => doc.data()).toList();
      _doctordetails = docquerySnapshot.docs.map((doc) => doc.data()).toList();
      _Date = docSnapshot['date'].toString();

      print("sdfdsf _doctordetails${_doctordetails}");
      print("sdfdsf _patientdetails${_patientdetails}");
      print("sdfdsf _scheduledetails${_scheduledetails[0]}");

      setState(() {
        _isLoading = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? bytes;
    Widget buildCard() => //take screen shot from container
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
                  ' Your Appointment Number is $_AppointmentNumber',
                  style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ' Your Appointment Date is On $_Date',
                  style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ' Appointment With Doctor: ${_doctordetails[0]['name']}',
                  style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ' Patient Name: ${_patientdetails[0]['name']}',
                  style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ' Venue: ${_scheduledetails[0]['venue']}',
                  style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ' Doctor will arrive at: ${_scheduledetails[0]['arivaltime']} ',
                  style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ' Doctor will leave at: ${_scheduledetails[0]['leavingtime']} ',
                  style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.black,
                      width: 2,
                    )),
                    color: primaryColor,
                    height: 200,
                    width: 200,
                    child: QrImage(
                      data: widget.Aid,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
                )
              ],
            ));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text(
            'Reciept',
            style: GoogleFonts.urbanist(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.1,
            ),
          ),
        ),
        body: _isLoading
            ? Center(
                child: LinearProgressIndicator(),
              )
            : buildCard(),
        bottomNavigationBar: _isLoading
            ? Text('')
            : BottomAppBar(
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
                              //download
                              final controller = ScreenshotController();
                              final bytes = await controller.captureFromWidget(
                                Material(child: buildCard()),
                              );
                              setState(() {
                                this.bytes = bytes;
                              });
                              await downloadReciept(bytes);
                            },
                            child: Text(
                              'Download Reciept',
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

Future downloadReciept(Uint8List bytes) async {
  // final storage=await getApplicationSupportDirectory();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Reference ref = await _storage
      .ref()
      .child('reciepts')
      .child(_auth.currentUser!.uid)
      .child('receipt.png');
  String id = const Uuid().v1();
  ref = ref.child(id);
  UploadTask uploadTask = ref.putData(bytes!);
  TaskSnapshot snap = await uploadTask;
  String downloadUrl = await snap.ref.getDownloadURL();
  print('downlurl ${downloadUrl}');
  final tempDir = await getTemporaryDirectory();
  final path = '${tempDir.path}/reciept.png';
  await Dio().download(downloadUrl, path);
  await GallerySaver.saveImage(path, albumName: 'Appointment Recipets');
  print("downloaded " );
  // final file=File('${storage.path}/reciept.png');
  // file.writeAsBytes(bytes);
}
