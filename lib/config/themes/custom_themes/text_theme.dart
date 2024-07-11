import 'package:flutter/material.dart';

class FTextTheme {
  FTextTheme._();

  static TextTheme light = TextTheme(
    titleLarge: const TextStyle(
        fontSize: 36, fontWeight: FontWeight.w800, fontFamily: "Nunito"),
    titleMedium: const TextStyle(
        fontSize: 30, fontWeight: FontWeight.w800, fontFamily: "Nunito"),
    titleSmall: const TextStyle(
        fontSize: 26, fontWeight: FontWeight.w800, fontFamily: "Nunito"),
    displayLarge: const TextStyle(
        fontSize: 22, fontWeight: FontWeight.w500, fontFamily: "Nunito"),
    displayMedium: const TextStyle(
        fontSize: 18, fontWeight: FontWeight.w500, fontFamily: "Nunito"),
    displaySmall: const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "Nunito"),
    bodyLarge: const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, fontFamily: "Nunito"),
    bodyMedium: const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, fontFamily: "Nunito"),
    bodySmall: const TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, fontFamily: "Nunito"),
    labelLarge: const TextStyle(
        fontSize: 12, fontWeight: FontWeight.w200, fontFamily: "Nunito"),
    labelMedium: const TextStyle(
        fontSize: 10, fontWeight: FontWeight.w200, fontFamily: "Nunito"),
    labelSmall: const TextStyle(
        fontSize: 8, fontWeight: FontWeight.w200, fontFamily: "Nunito"),
    headlineLarge: const TextStyle(
        fontSize: 26, fontWeight: FontWeight.w700, fontFamily: "Nunito"),
    headlineMedium: const TextStyle(
        fontSize: 22, fontWeight: FontWeight.w700, fontFamily: "Nunito"),
    headlineSmall: const TextStyle(
        fontSize: 18, fontWeight: FontWeight.w700, fontFamily: "Nunito"),
  );
  static TextTheme dark = TextTheme();
}
