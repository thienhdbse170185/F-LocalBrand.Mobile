import 'package:flutter/material.dart';

class InlineInput extends StatelessWidget {
  const InlineInput(
      {super.key,
      required this.height,
      required this.width,
      required this.inlineWidget});

  final Widget inlineWidget;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: inlineWidget,
      ),
    );
  }
}
