import 'package:appointment/screens/userScreens/appointmentselecttimescreen.dart';
import 'package:appointment/widgets/doctorcard.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          TextFieldInput(
            textEditingController: _searchController,
            label: '',
            hintText: 'Enter doctor name',
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          //doctor cards
          SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTap: () {},
              child: doctorcard(
                  imageUrl:
                      'https://img.freepik.com/free-photo/attractive-young-male-nutriologist-lab-coat-smiling-against-white-background_662251-2960.jpg',
                  name: 'john',
                  special: 'physician')),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => appointmenttime(
                              docid: 'J3DInUJOGmCEbd1JKSyv',
                            )));
              },
              child: doctorcard(
                  imageUrl:
                      'https://img.freepik.com/free-photo/attractive-young-male-nutriologist-lab-coat-smiling-against-white-background_662251-2960.jpg',
                  name: 'john',
                  special: 'physician'))
        ],
      ),
    ));
  }
}
