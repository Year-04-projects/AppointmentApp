import 'package:appointment/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/user_model.dart';
import '../../services/auth_services.dart';
import '../../widgets/nav_drawer.dart';
import '../authscreens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/results_model.dart';

import '../../services/resultServices.dart';
import 'editLabResult.dart';
import 'viewLabResult.dart';

class AllLabResults extends StatefulWidget {
  const AllLabResults({super.key});

  @override
  State<AllLabResults> createState() => _AllLabResultsState();
}

class _AllLabResultsState extends State<AllLabResults> {
  final Stream<QuerySnapshot> colRef = ResultService.readResults();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        color: secondaryColor,
        constraints: const BoxConstraints(maxWidth: 600),
        child: StreamBuilder(
            stream: colRef,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: snapshot.data!.docs.map((e) {
                      return Card(
                        color: Colors.white,
                        child: Column(children: [
                          ListTile(
                              contentPadding: const EdgeInsets.all(20),
                              title: Text(
                                e["Patient name"],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              subtitle: Container(
                                  child: (Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  // ignore: prefer_interpolation_to_compose_strings
                                  // Text(
                                  //   // ignore: prefer_interpolation_to_compose_strings
                                  //   "Age: " + e['age'].toString(),
                                  //   style: const TextStyle(fontSize: 16),
                                  // ),
                                  // const SizedBox(
                                  //   height: 8,
                                  // ),
                                  // // ignore: prefer_interpolation_to_compose_strings
                                  // Text(
                                  //   // ignore: prefer_interpolation_to_compose_strings
                                  //   "Tested By: " + e['Result name'],
                                  // ),
                                  // const SizedBox(
                                  //   height: 8,
                                  // ),
                                  // ignore: prefer_interpolation_to_compose_strings
                                  Text(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    "Test type: " + e['Test type'],
                                  ),
                                ],
                              )))),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: <Widget>[
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil<dynamic>(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          ViewResult(
                                        result: Result(
                                          uid: e.id,
                                          name: e["Result name"],
                                          age: e["age"],
                                          patientName: e["Patient name"],
                                          dropdownValue: e["Test type"],
                                        ),
                                      ),
                                    ),
                                    (route) => false,
                                  );
                                },
                                icon: const Icon(Icons.remove_red_eye),
                                label: const Text('View'),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil<dynamic>(
                                    context,
                                    MaterialPageRoute<dynamic>(
                                      builder: (BuildContext context) =>
                                          EditResult(
                                        result: Result(
                                          uid: e.id,
                                          name: e["Result name"],
                                          age: e["age"],
                                          patientName: e["Patient name"],
                                          dropdownValue: e["Test type"],
                                        ),
                                      ),
                                    ),
                                    (route) => false,
                                  );
                                },
                                icon: const Icon(Icons.edit),
                                label: const Text('Edit'),
                              ),
                              TextButton.icon(
                                onPressed: () async {
                                  var res = await ResultService.deleteLabResult(
                                      docId: e.id);
                                  if (res.code == 200) {
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content:
                                                Text(res.message.toString()),
                                          );
                                        });
                                  }
                                },
                                icon: const Icon(Icons.delete),
                                label: const Text('Delete'),
                              ),
                            ],
                          )
                        ]),
                      );
                    }).toList(),
                  ),
                );
              }
              return Container();
            }),
      ),
    ));
  }
}
