import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HorizontalGridList extends StatelessWidget {
  const HorizontalGridList({super.key, required this.delegate});
  final SliverChildDelegate delegate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(right: 32.0),
            sliver: SliverList(
              delegate: delegate,
            ),
          ),
        ],
      ),
    );
  }
}
