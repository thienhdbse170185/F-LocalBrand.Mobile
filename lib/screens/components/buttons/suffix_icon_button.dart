import 'package:f_localbrand/screens/components/inputs/inline_input.dart';
import 'package:flutter/material.dart';

class SuffixIconButton extends StatelessWidget {
  const SuffixIconButton(
      {super.key, required this.icon, required this.onPressed});

  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InlineInput(
        height: 32,
        width: 64,
        inlineWidget: IconButton(
          onPressed: onPressed,
          icon: icon,
        ));
  }
}
