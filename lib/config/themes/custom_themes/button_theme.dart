import 'package:f_localbrand/themes/material_theme.dart';
import 'package:flutter/material.dart';

class FButtonTheme {
  FButtonTheme._();

  static ElevatedButtonThemeData lightElevatedButtonTheme =
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
    backgroundColor: MaterialTheme.lightScheme().primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ));

  static OutlinedButtonThemeData lightOutlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      side: BorderSide(color: MaterialTheme.lightScheme().outline, width: 1),
      backgroundColor: Colors.white,
    ),
  );
}
