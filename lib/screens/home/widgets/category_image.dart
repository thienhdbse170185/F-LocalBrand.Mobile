import 'package:flutter/material.dart';

import '../../../config/themes/custom_themes/text_theme.dart';

class CategoryImage extends StatelessWidget {
  const CategoryImage(
      {super.key,
      required this.image,
      required this.title,
      required this.onPressed});

  final ImageProvider<Object> image;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: colorScheme.inversePrimary),
          child: GestureDetector(
            onTap: () {
              onPressed();
            },
            child: Image(
              image: image,
            ),
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
