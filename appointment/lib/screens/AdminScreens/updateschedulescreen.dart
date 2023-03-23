// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/schedule.service.dart';
import '../../utils/colors.dart';
import '../../widgets/common/Iconbtn.dart';
import '../../widgets/common/dateinputfield.dart';
import '../../widgets/common/tex_field_field.dart';

class UpdateScheduleScreen extends StatefulWidget {
  final String scheduleId;
  const UpdateScheduleScreen({super.key, required this.scheduleId});

  @override
  State<UpdateScheduleScreen> createState() => _UpdateScheduleScreenState();
}

class _UpdateScheduleScreenState extends State<UpdateScheduleScreen> {
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _patientcountController = TextEditingController();
  final TextEditingController _commentcontroller = TextEditingController();
  final TextEditingController _arrivaltimecontroller = TextEditingController();
  final TextEditingController _leavingtimecontroller = TextEditingController();

  List<String> items = ['None', 'ads', 'das'];
  List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List<String> selectedDays = [];

  var records;
  bool _isLoading = false;
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      var collection = FirebaseFirestore.instance.collection('schedule');
      var docSnapshot = await collection.doc(widget.scheduleId).get();
      // var records = docSnapshot.docs;
      print('Recors ${docSnapshot['daysavailable']}');
      _venueController.text = docSnapshot['venue'];
      final array = docSnapshot['daysavailable'];
      array.forEach((e) => selectedDays.add(e));
      print(selectedDays);
      _patientcountController.text = docSnapshot['patientcount'].toString();
      _commentcontroller.text = docSnapshot['comment'];
      _arrivaltimecontroller.text = docSnapshot['arivaltime'];
      _leavingtimecontroller.text = docSnapshot['leavingtime'];

      setState(() {
        records = docSnapshot;
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

  void updateShedule() async {
    final count = int.tryParse(_patientcountController.text);

    print('outputss ${records['docid']}');
    String res = await ScheduleService().updateschedule(
        arivaltime: _arrivaltimecontroller.text,
        leavingtime: _leavingtimecontroller.text,
        patientcount: count!,
        venue: _venueController.text,
        daysavailable: selectedDays,
        comment: _commentcontroller.text,
        docid: records['docid'],
        sid: widget.scheduleId);
    print('dfsfgdsgdf ${res}');
    if (res == 'Updated Schedule') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 3),
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //check view
    final isTablet = MediaQuery.of(context).size.width > 600;
    final inputPadding = const EdgeInsets.symmetric(vertical: 8.0);
    final inputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: progressBackgroundColor),
      borderRadius: BorderRadius.circular(12),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Text(
          'Update Schedule for ${widget.scheduleId.length > 15 ? widget.scheduleId.substring(0, 15) : widget.scheduleId}',
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.1,
          ),
        ),
        actions: [
          Icontbtn(
            onPressed: () {},
            icons: Icons.not_interested,
          ),
          SizedBox(
            width: 10,
          ),
          Icontbtn(
            onPressed: (() => updateShedule()),
            icons: Icons.save,
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
      body: _isLoading
          ? Text("loading data...")
          : SafeArea(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  width: double.infinity,
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                          delegate: SliverChildListDelegate([
                        SizedBox(
                          height: 20,
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          child: Column(
                                        children: [
                                          dateInputfield(
                                            controller: _arrivaltimecontroller,
                                            label: 'Arribval Time',
                                            hintText:
                                                'Select Doctor Arrival Time',
                                            withAsterisk: true,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFieldInput(
                                            textEditingController:
                                                _patientcountController,
                                            label: 'Patient Count',
                                            hintText:
                                                'Number of patients for schedule.',
                                            textInputType:
                                                TextInputType.datetime,
                                            textInputAction:
                                                TextInputAction.next,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Center(
                                          child: Column(
                                            children: [
                                              dateInputfield(
                                                controller:
                                                    _leavingtimecontroller,
                                                label: 'Leaving Time',
                                                hintText:
                                                    'Select Doctor Leaving Time',
                                                withAsterisk: true,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TextFieldInput(
                                                textEditingController:
                                                    _venueController,
                                                label: 'Venue',
                                                hintText:
                                                    'Doctor Appointment Room',
                                                textInputType:
                                                    TextInputType.text,
                                                textInputAction:
                                                    TextInputAction.next,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'Select Days of Appointment',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      // color: Colors.amberAccent,
                                      height: 50,
                                      width: MediaQuery.of(context).size.width *
                                          0.95,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: days.map((day) {
                                          final isSelected =
                                              selectedDays.contains(day);

                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (isSelected) {
                                                  selectedDays.remove(day);
                                                } else {
                                                  selectedDays.add(day);
                                                }
                                              });
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.129,
                                              margin: EdgeInsets.all(4),
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Color.fromARGB(
                                                      81, 0, 0, 0),
                                                  width: 1,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(isSelected
                                                            ? 0
                                                            : 0.3),
                                                    spreadRadius: 2,
                                                    blurRadius: 2,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: isSelected
                                                    ? primaryColor
                                                    : secondaryColor,
                                              ),
                                              child: Text(
                                                day,
                                                style: GoogleFonts.urbanist(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: -0.1,
                                                  color: isSelected
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Comment (Optional)',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _commentcontroller,
                                        maxLines: null,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          hintText: 'Any Comment',
                                          border: inputBorder,
                                          focusedBorder: inputBorder,
                                          enabledBorder: inputBorder,
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: redIconColor),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 14),
                                        ),
                                        style: GoogleFonts.urbanist(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ))
                      ]))
                    ],
                  ))),
    );
  }
}
