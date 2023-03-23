import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../utils/colors.dart';

class dateInputfield extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool withAsterisk;

  const dateInputfield({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.withAsterisk,
  });

  @override
  State<dateInputfield> createState() => _dateInputfieldState();
}

class _dateInputfieldState extends State<dateInputfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: widget.label,
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: widget.withAsterisk ? ' *' : '',
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: widget.controller,
            readOnly: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 0,
              ),
              hintText: widget.hintText,
              hintStyle: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: imageInputBorderColor,
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: progressBackgroundColor,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: progressBackgroundColor,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: greyTextColor,
                  width: 0,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: const Icon(Icons.timer_sharp),
            ),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (widget.withAsterisk && value!.isEmpty) {
                return 'Please enter a ${widget.hintText}.';
              }
              return null;
            },
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (pickedTime != null) {
                String formattedTime = pickedTime.format(context);

                setState(() {
                  widget.controller.text = formattedTime;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
