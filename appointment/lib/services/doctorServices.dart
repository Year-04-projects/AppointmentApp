import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/doctor_model.dart' as model;
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

class DoctorService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  Future<String> uploadImage(File pickedFile) async {
    const uid =  Uuid();
    final fileName = uid.v4();

    final reference = storage.ref().child('doctors/$fileName');
    print(reference);
    final uploadTask = reference.putFile(File(pickedFile.path));
    await uploadTask.whenComplete(() => print('File uploaded'));
    final imageUrl = await reference.getDownloadURL();
    print('Download URL: $imageUrl');
    return imageUrl;
  }

  Future<String> addDoctor({
    required String name,
    required String speciality,
    required String email,
    required String phone,
    required String photoUrl,
  }) async {
    print(name);
    print(speciality);
    print(email);
    print(phone);
    print(photoUrl);
    try {
      const uuid = Uuid();
      final CollectionReference usersCollection =
          _firestore.collection('doctors');

      model.Doctor doctor = model.Doctor(
        uid: uuid.v4(),
        name: name,
        speciality: speciality,
        email: email,
        phone: phone,
        photoUrl: photoUrl,
      );

      await _firestore
          .collection('doctors')
          .doc(doctor.uid)
          .set(doctor.tojson());
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }
}
