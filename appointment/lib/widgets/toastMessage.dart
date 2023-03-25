
import 'package:flutter/material.dart';

void toastMessage(BuildContext context, String message){
  final scaffold = ScaffoldMessenger.of(context);

  final snackdemo = SnackBar(
    content: Text(message),
    backgroundColor: Colors.green,
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(5),
    action: SnackBarAction(
        label: 'Close',
        onPressed: scaffold.hideCurrentSnackBar,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackdemo);

}