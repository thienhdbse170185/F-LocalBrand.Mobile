import 'package:flutter/material.dart';

class RoundedOutlinedButton extends StatelessWidget {
  const RoundedOutlinedButton(
      {super.key, required this.title, required this.onPressed, this.padding});

  final String title;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return OutlinedButton(
        onPressed: () {
          onPressed();
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 64, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
        ),
        child: Text(
          title,
          style: textTheme.displayMedium
              ?.copyWith(color: Theme.of(context).primaryColor),
        ));
  }
}
