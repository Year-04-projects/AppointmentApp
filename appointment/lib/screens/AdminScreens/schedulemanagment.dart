// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:appointment/widgets/datatable.dart';
import 'package:appointment/widgets/selectdoctormodal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/user_model.dart';
import '../../services/auth_services.dart';
import '../../utils/colors.dart';
import '../../widgets/nav_drawer.dart';

class ScheduleManagment extends StatefulWidget {
  const ScheduleManagment({super.key});

  @override
  State<ScheduleManagment> createState() => SscheduleManagmentState();
}

class SscheduleManagmentState extends State<ScheduleManagment> {
  
  User? _user;
  //get logged user details
  void userdetails() async {
    User user = await AuthServices().getUserDetails();
    print('name');
    print(user);
    setState(() {
      _user = user;
    });
  }

  @override
  void initState() {
    super.initState();
    userdetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text(
          'Admin Schedule Management',
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.1,
          ),
        ),
      ),
      drawer: NavDrawer(),
      body: Column(children: [
        Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('add search here')
                      // TextField(
                      //   decoration: InputDecoration(
                      //       hintText: 'Search Schedule',
                      //       // border:,
                      //       contentPadding: EdgeInsets.symmetric(
                      //           horizontal: 16, vertical: 12)),
                      // ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.file_download_outlined),
                                SizedBox(width: 5),
                                Text('Export XLS')
                              ],
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             ScheduleManagmentModal()));
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return selectdoctorpopup();
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add),
                                SizedBox(width: 5),
                                Text('Add New')
                              ],
                            )),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
        SizedBox(
          height: 10,
        ),
        Expanded(
            flex: 9,
            child: Padding(padding: EdgeInsets.all(10), child: tableWidget()))
      ]),
    );
  }
}
