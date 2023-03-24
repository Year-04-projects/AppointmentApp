import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/userScreens/appointmentselecttimescreen.dart';

class doctorcard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String special;
  final String docid;

  const doctorcard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.special,
    required this.docid,
  });

  get primaryColor => null;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Image.network(imageUrl, height: 100, fit: BoxFit.cover)),
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.urbanist(
                          fontSize: 15,
                          color: const Color.fromRGBO(30, 35, 44, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        special,
                        style: GoogleFonts.urbanist(
                          fontSize: 15,
                          color: const Color.fromRGBO(30, 35, 44, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        child: Container(
                            width: 100,
                            height: 50,
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              height: 30,
                              width: 100,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                ),
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => appointmenttime(
                                                docid: docid,
                                              )));
                                },
                                child: Text(
                                  'Select',
                                  style: GoogleFonts.urbanist(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
