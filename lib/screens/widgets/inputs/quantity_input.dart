import 'package:f_localbrand/screens/widgets/buttons/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuantityInput extends StatelessWidget {
  const QuantityInput(
      {super.key,
      required this.quantity,
      required this.onIncrease,
      required this.onDecrease});
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        CustomIconButton(
          icon: FontAwesomeIcons.minus,
          onPressed: () {
            if (quantity > 1) {
              onDecrease();
            }
          },
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          child: Text('$quantity'),
        ),
        CustomIconButton(
          icon: FontAwesomeIcons.plus,
          backgroundColor: colorScheme.primary,
          iconColor: Colors.white,
          onPressed: () {
            onIncrease();
          },
        ),
      ],
    );
  }
}
