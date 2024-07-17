import 'package:f_localbrand/config/themes/material_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onPressed?.call();
        context.pop();
      },
      icon: FaIcon(FontAwesomeIcons.arrowLeft),
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        side: BorderSide(color: MaterialTheme.lightScheme().outline, width: 1),
      ),
    );
  }
}
