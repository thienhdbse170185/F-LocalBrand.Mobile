import 'package:flutter/material.dart';

class FTextTheme {
  FTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
      headlineLarge: const TextStyle().copyWith(
          fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
      bodySmall: const TextStyle().copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 124, 95, 240)));
  static TextTheme darkTextTheme = TextTheme();
}
