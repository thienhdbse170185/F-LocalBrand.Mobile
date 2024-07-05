import 'package:flutter/material.dart';

class VerticalSliverList extends StatelessWidget {
  const VerticalSliverList(
      {super.key, this.height, required this.delegate, this.padding});

  final double? height;
  final SliverChildBuilderDelegate delegate;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.only(top: 20, bottom: 170),
      height: height ?? 700, // if height is null, set it to 700
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: delegate,
          ),
        ],
      ),
    );
  }
}
