import 'package:f_localbrand/themes/material_theme.dart';
import 'package:flutter/material.dart';

class FButtonTheme {
  FButtonTheme._();

  static ElevatedButtonThemeData lightElevatedButtonTheme =
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
    backgroundColor: MaterialTheme.darkScheme().primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ));
}
