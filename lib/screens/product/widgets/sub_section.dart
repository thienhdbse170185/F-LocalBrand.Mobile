import 'package:flutter/material.dart';

class SubSection extends StatelessWidget {
  const SubSection({super.key, required this.title, required this.widget});
  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: colorScheme.outlineVariant, width: 1.0),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.headlineSmall,
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            child: widget,
          )
        ],
      ),
    );
  }
}
