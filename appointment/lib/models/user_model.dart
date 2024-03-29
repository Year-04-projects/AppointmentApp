import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String role;
  final int age;
  final String photoUrl;

  const User({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.age = 1,
    required this.photoUrl,
  });

  Map<String, dynamic> tojson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'role': role,
        'age': age,
        'photoUrl': photoUrl,
      };

  static User fromJson(User user) {
    return User(
      uid: user.uid,
      name: user.name,
      email: user.email,
      role: user.role,
      age: user.age,
      photoUrl: user.photoUrl,
    );
  }

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot['uid'],
      name: snapshot['name'],
      email: snapshot['email'],
      role: snapshot['role'],
      age: snapshot['age'],
      photoUrl: snapshot['photoUrl'],
    );
  }
}
