import 'package:f_localbrand/screens/widgets/icons/icon_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpandedRoundedIconInput extends StatelessWidget {
  const ExpandedRoundedIconInput(
      {super.key,
      required this.textController,
      required this.hintText,
      required this.icon,
      this.onFieldSubmitted});

  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Expanded(
        child: SizedBox(
      width: 200,
      child: TextFormField(
          autocorrect: false,
          autofocus: false,
          keyboardType: TextInputType.text,
          controller: textController,
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            prefixIcon: IconInput(
              icon: FaIcon(icon),
            ),
          ),
          style: textTheme.bodyLarge,
          onFieldSubmitted: onFieldSubmitted),
    ));
  }
}
