import 'package:flutter/material.dart';

class FTextTheme {
  FTextTheme._();

  static TextTheme light = TextTheme(
    titleLarge: const TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
    titleMedium: const TextStyle(
        fontSize: 28, fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
    titleSmall: const TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
    displayLarge: const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "Montserrat"),
    displayMedium: const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, fontFamily: "Montserrat"),
    displaySmall: const TextStyle(
        fontSize: 12, fontWeight: FontWeight.w500, fontFamily: "Montserrat"),
    bodyLarge: const TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "Montserrat"),
    bodyMedium: const TextStyle(
        fontSize: 10, fontWeight: FontWeight.w400, fontFamily: "Montserrat"),
    bodySmall: const TextStyle(
        fontSize: 8, fontWeight: FontWeight.w400, fontFamily: "Montserrat"),
    labelLarge: const TextStyle(
        fontSize: 10, fontWeight: FontWeight.w200, fontFamily: "Montserrat"),
    labelMedium: const TextStyle(
        fontSize: 8, fontWeight: FontWeight.w200, fontFamily: "Montserrat"),
    labelSmall: const TextStyle(
        fontSize: 6, fontWeight: FontWeight.w200, fontFamily: "Montserrat"),
    headlineLarge: const TextStyle(
        fontSize: 20, fontWeight: FontWeight.w700, fontFamily: "Montserrat"),
    headlineMedium: const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w700, fontFamily: "Montserrat"),
    headlineSmall: const TextStyle(
        fontSize: 12, fontWeight: FontWeight.w700, fontFamily: "Montserrat"),
  );
  static TextTheme dark = TextTheme();
}
