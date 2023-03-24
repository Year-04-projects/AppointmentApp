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

class AllLabResults extends StatefulWidget {
  const AllLabResults({super.key});

  @override
  State<AllLabResults> createState() => _AllLabResultsState();
}

class _AllLabResultsState extends State<AllLabResults> {
  final Stream<QuerySnapshot> colRef = ResultService.readResults();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: StreamBuilder(
              stream: colRef,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView(
                      children: snapshot.data!.docs.map((e) {
                        return Card(
                          child: Column(children: [
                            ListTile(
                                title: Text(
                                  e["Result name"],
                                ),
                                subtitle: Container(
                                    child: (Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // ignore: prefer_interpolation_to_compose_strings
                                    Text("Age: " + e['age'].toString()),
                                  ],
                                )))),
                            ButtonBar(
                              alignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil<dynamic>(
                                      context,
                                      MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) =>
                                            EditResult(
                                          result: Result(
                                              uid: e.id,
                                              name: e["Result name"],
                                              age: e["age"]),
                                        ),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      var res =
                                          await ResultService.deleteLabResult(
                                              docId: e.id);
                                      if (res.code == 200) {
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                    res.message.toString()),
                                              );
                                            });
                                      }
                                    },
                                    icon: const Icon(Icons.delete)),
                              ],
                            )
                          ]),
                        );
                      }).toList(),
                    ),
                  );
                }
                return Container();
              })),
    );
  }
}
