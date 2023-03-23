import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String Aid;
  final String patientID;
  final String date;
  final int appointmentnumber;
  final String docid;

  const Appointment({
    required this.Aid,
    required this.patientID,
    required this.date,
    required this.appointmentnumber,
    required this.docid,
  });

  Map<String, dynamic> tojson() => {
        'Aid': Aid,
        'docid': docid,
        'patientID': patientID,
        'date': date,
        'appointmentnumber': appointmentnumber,
      };

  static Appointment fromJson(Appointment user) {
    return Appointment(
      Aid: user.Aid,
      patientID: user.patientID,
      date: user.date,
      appointmentnumber: user.appointmentnumber, 
      docid: user.docid,
    );
  }

  static Appointment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Appointment(
      Aid: snapshot['Aid'],
      docid: snapshot['docid'],
      patientID: snapshot['patientID'],
      date: snapshot['date'],
      appointmentnumber: snapshot['appointmentnumber'],
    );
  }
}
