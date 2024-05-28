import 'package:f_localbrand/themes/custom_themes/elevated_button.dart';
import 'package:f_localbrand/themes/custom_themes/input_decoration_theme.dart';
import 'package:f_localbrand/themes/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class FAppTheme {
  FAppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Montserrat',
      brightness: Brightness.light,
      primaryColor: Color(0xFFF83758),
      textTheme: FTextTheme.lightTextTheme,
      inputDecorationTheme: FInputDecorationTheme.lightInputDecorationTheme,
      elevatedButtonTheme: FElevatedButtonTheme.lightElevatedButtonTheme);
  static ThemeData darkTheme =
      ThemeData(useMaterial3: true, fontFamily: 'Montserrat');
}
