import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message){

  // Show the Snack bar
  final snackBar = SnackBar(
    content: Text(message),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Code to undo the action
        print('Undo action!');
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);


}