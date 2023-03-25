import 'package:cloud_firestore/cloud_firestore.dart';

class Result {
  String? uid;
  final String name;
  final int age;
  final String dropdownValue;
  final String patientName;

  Result(
      {this.uid,
      required this.name,
      required this.dropdownValue,
      required this.age,
      required this.patientName});

//   Map<String, dynamic> tojson() => {
//         'name': name,
//         'age': age,
//       };

//   static Result fromJson(Result result) {
//     return Result(
//       name: result.name,
//       age: result.age,
//     );
//   }

//   static Result fromSnap(DocumentSnapshot snap) {
//     var snapshot = snap.data() as Map<String, dynamic>;

//     return Result(
//       name: snapshot['name'],
//       age: snapshot['age'],
//     );
//   }
}
