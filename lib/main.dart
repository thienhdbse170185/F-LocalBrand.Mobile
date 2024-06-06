import 'package:f_localbrand/screens/auth/signup.dart';
import 'package:f_localbrand/themes/custom_themes/index.dart';
import 'package:f_localbrand/themes/material_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'screens/auth/login.dart';
import 'home.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final MaterialTheme materialTheme =
        MaterialTheme(FTextTheme.light, FButtonTheme.lightElevatedButtonTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'F-LocalBrand',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: ThemeMode.light,
      initialRoute: '/login',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen()
      },
    );
  }
}
