import 'package:f_localbrand/themes/theme.dart';
import 'package:flutter/material.dart';

import 'auth/login.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'F-LocalBrand',
      theme: FAppTheme.lightTheme,
      darkTheme: FAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen()
      },
    );
  }
}
