
import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  final String uid;
  final String name;
  final String speciality;
  final String email;
  final String phone;
  final String photoUrl;

  const Doctor({
    required this.uid,
    required this.name,
    required this.speciality,
    required this.email,
    required this.phone,
    required this.photoUrl,
  });

  Map<String, dynamic> tojson() => {
    'uid': uid,
    'name': name,
    'speciality': speciality,
    'email': email,
    'phone': phone,
    'photoUrl': photoUrl,
  };

  static Doctor fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Doctor(
      uid: snapshot['uid'],
      name: snapshot['name'],
      speciality: snapshot['speciality'],
      email: snapshot['email'],
      phone: snapshot['phone'],
      photoUrl: snapshot['photoUrl'],
    );
  }
}