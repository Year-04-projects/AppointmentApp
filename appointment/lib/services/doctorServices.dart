import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/doctor_model.dart' as model;
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

  Future<void> deleteImage(String url) async {
    await storage.refFromURL(url).delete();

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

  Future<model.Doctor> getDoctorDetails(String id) async {
    try {
        DocumentSnapshot snap =
        await _firestore.collection('doctors').doc(id).get();

        return model.Doctor.fromSnap(snap);

    } catch (e) {
      print('${e}');
      throw Exception(e);
    }
  }

  Future<String> updateDoctor({
    required String name,
    required String speciality,
    required String email,
    required String phone,
    required String photoUrl,
    required String docid,
  }) async {
    print(name);
    print(speciality);
    print(docid);
    print(photoUrl);

    try {
      model.Doctor schedule = model.Doctor(
        uid: docid,
        name: name,
        speciality: speciality,
        email: email,
        phone: phone,
        photoUrl: photoUrl,
      );

      await _firestore.collection('doctors').doc(docid).update(schedule.tojson());
      return 'success';
    } catch (e) {
      print('error doctor ${e}');
      return e.toString();
    }
  }

  Future<String> deleteDoctor({
    required String docid,
  }) async {
    print(docid);

    try {

      await _firestore.collection('doctors').doc(docid).delete();
      return 'success';
    } catch (e) {
      print('error doctor ${e}');
      return e.toString();
    }
  }

}
