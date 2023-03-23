
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class Icontbtn extends StatelessWidget {
  final Function()? onPressed;
  final IconData icons;
  final Color? lightColor;
  final Color? iconColor;

  const Icontbtn({
    super.key,
    required this.onPressed,
    required this.icons,
    this.lightColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed, // Handle your callback
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
        child: Ink(
          width: 42,
          decoration: BoxDecoration(
            color: lightPrimaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Icon(icons, color:Colors.white),
        ),
      ),
    );
  }
}