import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/userScreens/appointmentselecttimescreen.dart';

class doctorTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String special;
  final String docid;

  const doctorTile({
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
        padding: const EdgeInsets.symmetric(horizontal: 100.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Image.network(imageUrl, height: 150, width: 150,)),
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
                      const SizedBox(
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
                            width: 200,
                            height: 50,
                            alignment: Alignment.bottomRight,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundColor: primaryColor,
                                    child: IconButton(
                                      iconSize: 50,
                                      style: ButtonStyle(
                                        // borderRadius: BorderRadius.circular(100),
                                        foregroundColor: MaterialStateProperty.all(primaryColor),
                                      ),
                                      onPressed: () { },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ),
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
