import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/themes/material_theme.dart';

class BackButton extends StatefulWidget {
  const BackButton({super.key});

  @override
  State<BackButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<BackButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
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
