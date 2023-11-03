import 'package:flutter/material.dart';

void navigateToScreen(BuildContext context, Widget screen) {
 Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screen),
  );
}


void navigateToScreenAndExit(BuildContext context, Widget screen) {
  Navigator.pushReplacement(
    context,MaterialPageRoute(builder: (context) => screen));
}