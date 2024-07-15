import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CancelledTab extends StatefulWidget {
  const CancelledTab({super.key});

  @override
  State<CancelledTab> createState() => _CancelledTabState();
}

class _CancelledTabState extends State<CancelledTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Cancelled Orders'),
      ),
    );
  }
}
