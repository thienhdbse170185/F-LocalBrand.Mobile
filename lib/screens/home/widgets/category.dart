import 'package:f_localbrand/config/themes/custom_themes/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category extends StatelessWidget {
  const Category({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: colorScheme.inversePrimary),
          child: IconButton(
            onPressed: () {},
            icon: FaIcon(icon),
          ),
        ),
        Text(
          title,
          style: FTextTheme.light.displayMedium?.copyWith(fontSize: 14),
        )
      ],
    );
  }
}
