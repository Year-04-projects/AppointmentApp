import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final String sid;
  final String docid;
  final String arivaltime;
  final String leavingtime;
  final int patientcount;
  final String venue;
  final List<String> daysavailable;
  final String comment;

  const Schedule({
    required this.docid,
    required this.arivaltime,
    required this.leavingtime,
    required this.patientcount,
    required this.venue,
    required this.daysavailable,
    required this.comment,
    required this.sid,
  });

  Map<String, dynamic> tojson() => {
        'sid': sid,
        'docid': docid,
        'arivaltime': arivaltime,
        'leavingtime': leavingtime,
        'patientcount': patientcount,
        'venue': venue,
        'daysavailable': daysavailable,
        'comment': comment,
      };

  static Schedule fromJson(Schedule schedule) {
    return Schedule(
      sid: schedule.sid,
      arivaltime: schedule.arivaltime,
      leavingtime: schedule.leavingtime,
      patientcount: schedule.patientcount,
      venue: schedule.venue,
      daysavailable: schedule.daysavailable,
      comment: schedule.comment,
      docid: schedule.docid,
    );
  }

  static Schedule fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Schedule(
      sid: snapshot['sid'],
      arivaltime: snapshot['arivaltime'],
      leavingtime: snapshot['leavingtime'],
      patientcount: snapshot['patientcount'],
      venue: snapshot['venue'],
      daysavailable: snapshot['daysavailable'],
      comment: snapshot['comment'],
      docid: snapshot['docid'],
    );
  }
}
