import 'package:f_localbrand/screens/widgets/buttons/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckoutInformation extends StatelessWidget {
  const CheckoutInformation(
      {super.key,
      required this.title,
      required this.headline,
      required this.description,
      this.onChange});

  final String title;
  final String headline;
  final String description;
  final VoidCallback? onChange;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: textTheme.headlineMedium),
      Padding(
        padding: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 35),
                  child: FaIcon(FontAwesomeIcons.locationDot,
                      color: colorScheme.primary),
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      headline,
                      style: textTheme.displayMedium,
                    ),
                    SizedBox(
                      width: 240,
                      child: Text(
                        description,
                        style: textTheme.displaySmall?.copyWith(
                            fontSize: 14, color: colorScheme.outline),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CustomIconButton(
              onPressed: () {},
              icon: FontAwesomeIcons.pencil,
            ),
          ],
        ),
      )
    ]);
  }
}
