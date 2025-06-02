import 'package:flutter/material.dart';

final darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      surface: Color.fromARGB(255, 0, 0, 0),
      primary: Color.fromARGB(255, 63, 63, 63),
      secondary: Color.fromARGB(255, 43, 43, 43),
      inversePrimary: Color.fromARGB(255, 206, 206, 206),
    ));
