import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:chivuolesserelaureato/screens/intro_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
    ),
  );
  doWhenWindowReady(() {
    appWindow.maximize();
    appWindow.show();
  });
}
