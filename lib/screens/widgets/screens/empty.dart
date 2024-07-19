import 'package:f_localbrand/config/themes/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class EmptyOrder extends StatelessWidget {
  const EmptyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 500,
        child: Column(
          children: [
            Image.asset(
              'assets/images/empty_favourite.png',
              width: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Orders is emty',
                style: FTextTheme.light.displayMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
