import 'package:flutter/material.dart';

class Snackbar {
  static void showSnackbar(BuildContext context, GlobalKey<ScaffoldState> key, Color color, String text) {
    if (context == null) return;
    if (key == null) return;
    if (key.currentState == null) return;

    FocusScope.of(context).requestFocus(new FocusNode());

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        content: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: color,
        duration: Duration(seconds: 3)));
  }
}
