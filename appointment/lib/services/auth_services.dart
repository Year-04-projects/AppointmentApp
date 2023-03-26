import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import '../models/user_model.dart' as model;
import 'package:flutter/foundation.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  //! Get logged user Details
  Future<model.User> getUserDetails() async {
    print('imherent');
    try {
      final currentUser = _auth.currentUser!;
      if (currentUser != null) {
        DocumentSnapshot snap =
            await _firestore.collection('users').doc(currentUser.uid).get();

        return model.User.fromSnap(snap);
      }else{
        throw Exception('Curren user is null or');
      }
    } catch (e) {
      print('erroatgetr${e}');
      throw Exception(e);
    }
  }

// user register
  Future<String> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        //check if this is the first user to the system
        final CollectionReference usersCollection =
            _firestore.collection('users');

        var role;
        usersCollection.get().then((value) {
          if (value.docs.isNotEmpty) {
            print(' collection exists!');
            role = 'user';
          } else {
            print(' collection does not exist.');
            role = 'admin';
          }
        });

        // register user to firebase authentication
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // add user to users collection in firebase datastore
        model.User user = model.User(
            uid: cred.user!.uid,
            name: name,
            email: email,
            role: role,
            photoUrl: '',
        );
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.tojson());

        res = 'success';
      }
    } catch (err) {
      print('error ${err}');
      res = err.toString();
    }
    return res;
  }

  //sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  //user login
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'please enter all the fields.';
      }
    } catch (err) {
      String errorMessage = err.toString();
      RegExp regExp = new RegExp(r"\[.*\]");
      Match? match = regExp.firstMatch(errorMessage);

      if (match != null) {
        errorMessage = match.group(0)!;
      }
      res = errorMessage;
    }

    return res;
  }

  Future<String> updateUser({
    required String name,
    required int age,
    required String photoUrl,
    required String role,
    required String email,
    required String docid,
  }) async {

    print(name);
    print(docid);
    print(photoUrl);

    try {

      model.User user = model.User(
        uid: docid,
        name: name,
        age: age,
        role: role,
        email: email,
        photoUrl: photoUrl,
      );

      await _firestore.collection('users').doc(docid).update(user.tojson());
      return 'success';
    } catch (e) {
      print('error doctor ${e}');
      return e.toString();
    }
  }

  Future<void>deleteAccount(String docid) async {
    await _firestore.collection('users').doc(docid).delete();
    _auth.currentUser?.delete();
    _auth.signOut();


  }

  Future<String> uploadImage(File pickedFile) async {
    const uid =  Uuid();
    final fileName = uid.v4();

    final reference = storage.ref().child('users/$fileName');
    print(reference);
    final uploadTask = reference.putFile(File(pickedFile.path));
    await uploadTask.whenComplete(() => print('Image uploaded'));
    final imageUrl = await reference.getDownloadURL();
    print('Download URL: $imageUrl');
    return imageUrl;
  }

  Future<void> deleteImage(String url) async {
    await storage.refFromURL(url).delete();
  }

}