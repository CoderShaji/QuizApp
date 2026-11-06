import 'package:flutter/material.dart';

Future<bool> alertdialog({
  required BuildContext context,
  required String title,
  required content,
}) async {
  bool confirm = false;
  Widget yesButton = TextButton(
    onPressed: () {
      confirm = true;
      Navigator.of(context).pop(true);
    },
    child: Text('Yes', style: TextStyle()),
  );
  Widget noButton = TextButton(
    onPressed: () {
      confirm = false;
      Navigator.pop(context,false);
    },
    child: Text('No', style: TextStyle()),
  );
  AlertDialog alertDialog = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [noButton, yesButton],
  );
  await showDialog(
    context: context,
    builder: (context) {
      return alertDialog;
    },
  );
  return confirm;
}
Future<bool> erroralertdialog({
  required BuildContext context,
  required String title,
  required content,
}) async {
  bool confirm = false;
  Widget yesButton = TextButton(
    onPressed: () {
      confirm = true;
      Navigator.of(context).pop(true);
    },
    child: Text('Ok', style: TextStyle()),
  );

  AlertDialog alertDialog = AlertDialog(
    title: Text(title,style: TextStyle(
      color: Colors.red
    ),),
    content: Text(content, style: TextStyle(
      color: Colors.red
    ),),
    actions: [ yesButton],
  );
  await showDialog(
    context: context,
    builder: (context) {
      return alertDialog;
    },
  );
  return confirm;
}