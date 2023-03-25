import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/schedule_model.dart' as model;
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class ScheduleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addschedule({
    required String arivaltime,
    required String leavingtime,
    required int patientcount,
    required String venue,
    required List<String> daysavailable,
    required String comment,
    required String docid,
  }) async {
    print(arivaltime);
    print(leavingtime);
    print(patientcount);
    print(venue);
    print(daysavailable);
    print(comment);
    print(docid);
    try {
      var uuid = Uuid();
      final CollectionReference usersCollection =
          _firestore.collection('schedule');

      model.Schedule schedule = model.Schedule(
        sid: uuid.v4(),
        docid: docid,
        arivaltime: arivaltime,
        leavingtime: leavingtime,
        patientcount: patientcount,
        venue: venue,
        daysavailable: daysavailable,
        comment: comment,
      );

      await _firestore
          .collection('schedule')
          .doc(schedule.sid)
          .set(schedule.tojson());
      return 'Added Schedule';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> deleteSchedule(String sid) async {
    String res = 'some error occured';
    try {
      // Delete Schedule
      await _firestore.collection('schedule').doc(sid).delete();

      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> updateschedule({
    required String sid,
    required String arivaltime,
    required String leavingtime,
    required int patientcount,
    required String venue,
    required List<String> daysavailable,
    required String comment,
    required String docid,
  }) async {
    print(arivaltime);
    print(leavingtime);
    print(patientcount);
    print(venue);
    print(daysavailable);
    print(comment);
    print(docid);

    try {
      final CollectionReference usersCollection =
          _firestore.collection('schedule');

      model.Schedule schedule = model.Schedule(
        sid: sid,
        docid: docid,
        arivaltime: arivaltime,
        leavingtime: leavingtime,
        patientcount: patientcount,
        venue: venue,
        daysavailable: daysavailable,
        comment: comment,
      );

      await _firestore
          .collection('schedule')
          .doc(sid)
          .update(schedule.tojson());
      return 'Updated Schedule';
    } catch (e) {
      print('erroratschedule ${e}');
      return e.toString();
    }
  }
}
