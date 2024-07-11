import 'package:f_localbrand/screens/widgets/texts/text_pressed.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SubSectionHome extends StatelessWidget {
  const SubSectionHome(
      {super.key,
      required this.title,
      this.hasAllText = false,
      required this.body,
      required this.textTheme,
      this.onTapAll,
      this.paddingTop = 50});
  final String title;
  final bool hasAllText;
  final VoidCallback? onTapAll;
  final Widget body;
  final TextTheme textTheme;
  final double paddingTop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: textTheme.headlineMedium,
              ),
              hasAllText
                  ? TextPressed(
                      onTap: () {
                        onTapAll?.call();
                      },
                      text: 'All',
                    )
                  : Container()
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: body,
          )
        ],
      ),
    );
  }
}
