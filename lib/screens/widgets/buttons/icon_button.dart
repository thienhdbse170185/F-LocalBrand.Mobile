import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key,
      this.onPressed,
      required this.icon,
      this.iconColor,
      this.backgroundColor,
      this.iconSize = 18});

  final VoidCallback? onPressed;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed?.call(),
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? Colors.transparent,
          border: Border.all(
            color: backgroundColor == null
                ? Theme.of(context).colorScheme.outline
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Center(
          child: FaIcon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
