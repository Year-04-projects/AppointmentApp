import 'package:appointment/models/lab_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final CollectionReference _collection = _firestore.collection('labResults');

class ResultService {
  static Future<LabResponse> addResult({
    required String name,
    required int age,
  }) async {
    LabResponse res = LabResponse();
    DocumentReference docRef = _collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "Result name": name,
      "age": age,
    };

    var result = await docRef.set(data).whenComplete(() {
      res.code = 200;
      res.message = "Successful";
    }).catchError((e) {
      res.code = 500;
      res.message = e;
    });

    return res;
  }

  static Stream<QuerySnapshot> readResults() {
    CollectionReference labResultsCollection = _collection;

    return labResultsCollection.snapshots();
  }
}
