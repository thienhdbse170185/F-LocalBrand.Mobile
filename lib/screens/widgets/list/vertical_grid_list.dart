import 'package:flutter/material.dart';

class VerticalGridList extends StatefulWidget {
  const VerticalGridList(
      {super.key, this.height, required this.delegate, this.padding});

  final double? height;
  final SliverChildBuilderDelegate delegate;
  final EdgeInsetsGeometry? padding;

  @override
  State<VerticalGridList> createState() => _VerticalGridListState();
}

class _VerticalGridListState extends State<VerticalGridList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ?? EdgeInsets.only(top: 20, bottom: 150),
      height: widget.height ?? 650, // if height is null, set it to 700
      child: CustomScrollView(
        slivers: [
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.75),
            delegate: widget.delegate,
          ),
        ],
      ),
    );
  }
}
