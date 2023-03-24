import 'package:cloud_firestore/cloud_firestore.dart';

class Result {
  final String name;
  final int age;

  const Result({
    required this.name,
    required this.age,
  });

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
