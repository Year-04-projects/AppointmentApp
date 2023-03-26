import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/AdminScreens/doctorUpdate.dart';
import '../utils/colors.dart';

class DoctorTile extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String special;
  final String phone;
  final String email;
  final String docid;

  const DoctorTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.special,
    required this.phone,
    required this.email,
    required this.docid,
  });

  @override
  State<DoctorTile> createState() => _DoctorTileState();
}

class _DoctorTileState extends State<DoctorTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Image.network(widget.imageUrl, height: 150, width: 150,)),
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
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
                        widget.special,
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
                              height: 50,
                              width: 100,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: primaryColor,
                                child: IconButton(
                                  iconSize: 50,
                                  style: ButtonStyle(
                                    // borderRadius: BorderRadius.circular(100),
                                    foregroundColor: MaterialStateProperty.all(primaryColor),
                                  ),
                                  onPressed: () {
                                    print(widget.docid);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DoctorUpdate(
                                                id: widget.docid,
                                                name: widget.name,
                                                special: widget.special,
                                                imageUrl: widget.imageUrl,
                                            email: widget.email,
                                            phone: widget.phone,
                                              ),
                                        ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
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
