import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../services/auth_services.dart';
import '../../utils/colors.dart';
import '../../widgets/doctorTile.dart';
import '../../widgets/doctorcard.dart';
import '../../widgets/nav_drawer.dart';
import 'addDoctor.dart';

class DoctorsHome extends StatefulWidget {
  const DoctorsHome({Key? key}) : super(key: key);
  @override
  State<DoctorsHome> createState() => _DoctorsHomeState();
}

class _DoctorsHomeState extends State<DoctorsHome> {
  User? _user;
  bool _isLoading = false;
  var records;
  //get logged user details
  void userdetails() async {
    User user = await AuthServices().getUserDetails();
    print('name');
    print(user);
    setState(() {
      _user = user;
    });
  }

  getData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      var collection = FirebaseFirestore.instance.collection('doctors');
      var docSnapshot = await collection.get();

      print('Records ${docSnapshot.docs.map((e) => print(e['name']))}');
      setState(() {
        records = docSnapshot.docs;
      });
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    userdetails();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors Home"),
        backgroundColor: primaryColor,
      ),
      drawer: NavDrawer(user: _user),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream:
                FirebaseFirestore.instance.collection('doctors').snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: LinearProgressIndicator(),
                    );
                  }
                  List doctors = snapshot.data!.docs;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: doctors.length,
                      itemBuilder: (context, index) {
                        final data = doctors[index].data();
                        return doctorTile(
                          imageUrl: data["photoUrl"],
                          name: data["name"],
                          special: data['speciality'],
                          docid: data["uid"],
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDoctor()),
          );
        },
        backgroundColor: primaryColor,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
