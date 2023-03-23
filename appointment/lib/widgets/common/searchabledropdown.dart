import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/colors.dart';

class SearchableDropDownField extends StatefulWidget {
  final TextEditingController doctorController;
  final String label;
  final String hintText;
  final bool withAsterisk;
  final String selectValue;
  final bool isPass;
  final List<String> items;
  final Function(String?) onChanged;
  final TextInputAction? textInputAction;

  const SearchableDropDownField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.withAsterisk,
    required this.selectValue,
    required this.items,
    required this.onChanged,
    this.isPass = false,
    this.textInputAction, 
    required this.doctorController,
  }) : super(key: key);

  @override
  _SearchableDropDownFieldState createState() =>
      _SearchableDropDownFieldState();
}

class _SearchableDropDownFieldState extends State<SearchableDropDownField> {
  final TextEditingController _fieldvalue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: progressBackgroundColor),
      borderRadius: BorderRadius.circular(12),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
              const Spacer(),
            ],
          ),
          TextFormField(
            style: GoogleFonts.urbanist(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            controller: widget.doctorController,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: inputBorder,
              focusedBorder: inputBorder,
              enabledBorder: inputBorder,
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: redIconColor),
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
            keyboardType: TextInputType.text,
            obscureText: widget.isPass,
            textInputAction: widget.textInputAction,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter value';
              }
              return null;
            },
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding:  EdgeInsets.all(1),
                  child: GestureDetector(
                    child: ListTile(
                      title: Text(widget.items[index]),
                    ),
                    onTap: () {
                      setState(() {
                        widget.doctorController.text = widget.items[index];
                      });

                      // print('dasfasfsd ${widget.items[index]}');
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
