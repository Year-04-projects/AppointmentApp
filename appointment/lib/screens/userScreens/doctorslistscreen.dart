import 'package:appointment/screens/userScreens/appointmentselecttimescreen.dart';
import 'package:appointment/widgets/doctorcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/common/tex_field_field.dart';

class doctorslist extends StatefulWidget {
  const doctorslist({super.key});

  @override
  State<doctorslist> createState() => _doctorslistState();
}

class _doctorslistState extends State<doctorslist> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  var _doctordetails;
  @override
  void initState() {
    super.initState();
    print('_doctordetailss${_searchController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
        children: [
          TextFieldInput(
            textEditingController: _searchController,
            label: '',
            hintText: 'Enter doctor name',
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          //doctor cards
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
                if (_searchController.text.isNotEmpty) {
                  doctors = doctors
                      .where((_element) => _element
                          .data()['name']
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase()))
                      .toList();
                  print('doctorssd=${doctors}');
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      final data = doctors[index].data();
                      return doctorcard(
                        imageUrl: data["photoUrl"],
                        name: data["name"],
                        special: data['speciality'],
                        docid: data["uid"],
                      );
                    });
              },
            ),
          )

          // for (Map doctor in _doctordetails)
        ],
      ),
    );
  }
}
