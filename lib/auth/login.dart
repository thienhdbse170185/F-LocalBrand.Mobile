import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _dismissSnackbar() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Processing...')));
      _setLoadingTrue();
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      try {
        final response = await http.post(
          Uri.parse('${dotenv.env['API_URL']}/Auth/Login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}),
        );

        if (response.statusCode == 200) {
          // Login successful, handle the response data
          final Map<String, dynamic> data = jsonDecode(response.body);
          // You can save the user token or other relevant data here
          print('Login successful: $data');
          _setLoadingFalse();
          _dismissSnackbar();
          await Navigator.pushNamed(context, '/');
        } else {
          // Login failed, handle the error
          print('Login failed: ${response.statusCode} - ${response.body}');
        }
      } catch (e) {
        // Handle any exceptions that occurred during the API call
        print('Error: $e');
      }
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
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
  void initState() {
    super.initState();
    _resetLoginState();
  }

  void _resetLoginState() {
    setState(() {
      _emailController.clear();
      _passwordController.clear();
      _obscureText = true;
      _isLoading = false;
    });
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
            const EdgeInsets.only(top: 72, right: 36, bottom: 48, left: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_isLoading ? 'Logging in...' : 'Welcome back,',
                      style: textTheme.titleMedium),
                  const SizedBox(height: 5),
                  Text(
                      _isLoading
                          ? 'Please wait...'
                          : 'Discover Limitless Choices and Unmatched Convenience.',
                      style: textTheme.displayMedium),
                  const SizedBox(height: 48),
                ],
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 96,
                      child: TextFormField(
                        autocorrect: false,
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*Please enter an email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 20),
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
                    ),
                    SizedBox(
                      height: 90,
                      child: TextFormField(
                        autocorrect: false,
                        autofocus: false,
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*Please enter a password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 20),
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
                              _obscureText
                                  ? Ionicons.eye_off_outline
                                  : Ionicons.eye_outline,
                            ),
                          ),
                        ),
                        obscureText: _obscureText,
                        style: textTheme.bodyLarge,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          print('tapped');
                        },
                        child: Text(
                          'Forgot Password?',
                          textAlign: TextAlign.right,
                          style: textTheme.displaySmall?.copyWith(
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
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
                                  'Login',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                        )),
                  ],
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
                          'Don\'t have an account?',
                          style: textTheme.displaySmall,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            'Sign Up',
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
