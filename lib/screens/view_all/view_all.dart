import 'package:f_localbrand/screens/widgets/appbars/custom_appbar.dart';
import 'package:flutter/material.dart';

class ViewAllScreen extends StatefulWidget {
  const ViewAllScreen({super.key, required this.title});
  final String title;

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: Column(
      children: [CustomAppbar(title: widget.title, textTheme: textTheme)],
    ));
  }
}
