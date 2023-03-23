import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class doctorcard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String special;

  const doctorcard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.special,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Image.network(
                    imageUrl,
                    height: 100,
                    fit: BoxFit.cover)),
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
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
