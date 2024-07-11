import 'package:flutter/material.dart';

class AvatarOval extends StatelessWidget {
  const AvatarOval({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.isBorder = false,
  });

  final ImageProvider image;
  final double? height;
  final double? width;
  final bool? isBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: isBorder == true
            ? Border.all(
                color: Theme.of(context).primaryColor,
                width: 3.0,
              )
            : null,
      ),
      child: ClipOval(
        child: Image(
          image: image,
          height: height ?? 120,
          width: width ?? 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
