import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/colors.dart';

class DropDownField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool withAsterisk;
  final String selectValue;
  final List<String> items;
  final Function(String?) onChanged;

  const DropDownField({
    super.key,
    required this.label,
    required this.hintText,
    required this.withAsterisk,
    required this.selectValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: withAsterisk ? ' *' : '',
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonFormField(
                value: selectValue == 'None' ? null : selectValue,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(right: 12),
                  hintText: '   $hintText',
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
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: progressBackgroundColor,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
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
                ),
                items: items
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e,
                        child: Text(
                          e,
                          style: GoogleFonts.urbanist(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: onChanged,
                validator: (value) {
                  if (withAsterisk && value == null) {
                    return 'Please enter a $hintText.';
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
