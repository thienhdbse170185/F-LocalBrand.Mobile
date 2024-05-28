import 'package:flutter/material.dart';

class FInputDecorationTheme {
  FInputDecorationTheme._();

  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: Colors.black)));
}
