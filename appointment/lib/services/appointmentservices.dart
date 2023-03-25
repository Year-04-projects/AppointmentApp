import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/appointments_model.dart' as model;
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Object> addappointment({
    required String date,
    required String docid,
  }) async {
    print('coufdsnt here is ${date}');
    try {
      DateTime dateTime = DateTime.parse(date);
      String dateStr = DateFormat('yyyy-MM-dd').format(dateTime);
      final FirebaseAuth _auth = FirebaseAuth.instance;
      User? currentUser = _auth.currentUser;
//get count of docs
      CollectionReference appointmentRef =
          FirebaseFirestore.instance.collection('appointment');
      QuerySnapshot querySnapshot =
          await appointmentRef
          .where('docid',isEqualTo:docid )
          .where('date', isEqualTo: dateStr)
          .get();
      // print('countofdocs snapshot${querySnapshot}');
      int count = querySnapshot.size;
      // print('countofdocs${count} }');
      print('coufdsnt$count');
      var data = querySnapshot.docs.map((doc) => doc.data()).toList();

      print('coufdsnt date $dateStr $data[0]["date"]');

      var uuid = Uuid();
      final Aid = await uuid.v4();
      if (currentUser != null) {
        model.Appointment appointment = model.Appointment(
          docid: docid,
          Aid: Aid,
          patientID: currentUser.uid,
          date: dateStr,
          appointmentnumber: count + 1,
        );
        final a = {'Aid': Aid, 'msg': 'Placed Appointment'};
        await _firestore
            .collection('appointment')
            .doc(appointment.Aid)
            .set(appointment.tojson());
        return a;
      }
    } catch (e) {
      print('errr $e');
      return e.toString();
    }
    return 'a';
  }
}
