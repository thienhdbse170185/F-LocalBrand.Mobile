import 'package:flutter/material.dart';

class HomeItemScreen extends StatefulWidget {
  const HomeItemScreen({super.key});

  @override
  State<HomeItemScreen> createState() => _HomeItemScreenState();
}

class _HomeItemScreenState extends State<HomeItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const Text('Home Screen'),
      ),
    );
  }
}
