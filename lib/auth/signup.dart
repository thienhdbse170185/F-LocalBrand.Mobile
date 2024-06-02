import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscureConfirm = true;
  bool _obscurePassword = true;
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  Future<void> _login() async {
    _setLoadingTrue();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirm = _confirmController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/Auth/Login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      _setLoadingFalse();
      if (response.statusCode == 200) {
        // Login successful, handle the response data
        final Map<String, dynamic> data = jsonDecode(response.body);
        // You can save the user token or other relevant data here
        print('Login successful: $data');
        await Navigator.pushReplacementNamed(context, '/');
      } else {
        // Login failed, handle the error
        print('Login failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions that occurred during the API call
      print('Error: $e');
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmVisibility() {
    setState(() {
      _obscureConfirm = !_obscureConfirm;
    });
  }

  void _setLoadingTrue() {
    setState(() {
      _isLoading = true;
    });
  }

  void _setLoadingFalse() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ElevatedButtonThemeData elevatedButtonTheme =
        Theme.of(context).elevatedButtonTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 72, right: 36, bottom: 36, left: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_isLoading ? 'Submitting...' : 'Register',
                      style: textTheme.titleMedium),
                  const SizedBox(height: 5),
                  Text(
                      _isLoading
                          ? 'Your account is being created...'
                          : 'Please enter your details',
                      style: textTheme.displayMedium),
                  const SizedBox(height: 48),
                ],
              ),
            ),
            TextFormField(
              autocorrect: false,
              autofocus: false,
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Email",
                contentPadding: const EdgeInsets.symmetric(vertical: 20),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                prefixIcon: const Icon(Ionicons.mail),
              ),
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: 28),
            TextFormField(
              autocorrect: false,
              autofocus: false,
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                contentPadding: const EdgeInsets.symmetric(vertical: 20),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                prefixIcon: const Icon(Ionicons.lock_closed),
                suffixIcon: IconButton(
                  onPressed: _togglePasswordVisibility,
                  icon: Icon(
                    _obscurePassword
                        ? Ionicons.eye_off_outline
                        : Ionicons.eye_outline,
                  ),
                ),
              ),
              obscureText: _obscurePassword,
              style: textTheme.bodyLarge,
            ),
            const SizedBox(height: 28),
            TextFormField(
              autocorrect: false,
              autofocus: false,
              controller: _confirmController,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
                contentPadding: const EdgeInsets.symmetric(vertical: 20),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                prefixIcon: const Icon(Ionicons.lock_closed),
                suffixIcon: IconButton(
                  onPressed: _toggleConfirmVisibility,
                  icon: Icon(
                    _obscureConfirm
                        ? Ionicons.eye_off_outline
                        : Ionicons.eye_outline,
                  ),
                ),
              ),
              obscureText: _obscureConfirm,
              style: textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: elevatedButtonTheme.style,
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.white),
                        ),
                )),
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    Text(
                      '- OR Continue With -',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: colorScheme.onSurface),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colorScheme.inversePrimary,
                            width: 1.0,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 24.0,
                          child: Image.asset(
                            'assets/icon/google.png',
                            width: 32.0,
                            height: 32.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: textTheme.displaySmall,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(context, '/login');
                          },
                          child: Text(
                            'Login',
                            style: textTheme.displaySmall?.copyWith(
                                color: Theme.of(context).primaryColor,
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    Theme.of(context).primaryColor),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
