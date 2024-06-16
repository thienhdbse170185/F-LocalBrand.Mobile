import 'package:f_localbrand/firebase_options.dart';
import 'package:f_localbrand/screens/auth/index.dart';
import 'package:f_localbrand/themes/custom_themes/index.dart';
import 'package:f_localbrand/themes/material_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'home.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final MaterialTheme materialTheme = MaterialTheme(
        FTextTheme.light,
        FButtonTheme.lightElevatedButtonTheme,
        FButtonTheme.lightOutlinedButtonTheme);

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
        '/signup': (context) => const SignupScreen(),
        '/forgot_pw': (context) => const ForgotPasswordScreen(),
        '/otp': (context) => const OTPScreen(),
        '/reset_pw': (context) => const ResetPasswordScreen(),
      },
    );
  }
}
