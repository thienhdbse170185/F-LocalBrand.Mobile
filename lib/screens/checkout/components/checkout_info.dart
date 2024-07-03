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
      Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      Padding(
        padding: EdgeInsets.only(top: 10),
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
                      style: textTheme.displaySmall,
                    ),
                    SizedBox(
                      width: 240,
                      child: Text(
                        description,
                        style: textTheme.displaySmall?.copyWith(
                            fontSize: 13, color: colorScheme.outline),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            OutlinedButton(
              onPressed: () {
                onChange?.call();
              },
              style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100))),
              child: Text(
                'CHANGE',
                style: textTheme.displaySmall
                    ?.copyWith(fontSize: 11, color: colorScheme.primary),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
