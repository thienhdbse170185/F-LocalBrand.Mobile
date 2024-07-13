import 'package:f_localbrand/config/themes/material_theme.dart';
import 'package:flutter/material.dart';

class TextPressed extends StatelessWidget {
  const TextPressed(
      {super.key,
      required this.onTap,
      required this.text,
      required this.textTheme});
  final VoidCallback onTap;
  final String text;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Text(text,
          style: textTheme.displayMedium?.copyWith(
              color: MaterialTheme.lightScheme().primary,
              decoration: TextDecoration.underline)),
    );
  }
}
