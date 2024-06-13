import 'dart:convert';

import 'package:f_localbrand/screens/components/buttons/google_login.dart';
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
  String? _emailErrorMessage, _passwordErrorMessage;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _dismissSnackbar() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  bool validateInput(String? email, String? password) {
    if (email == null || email.isEmpty) {
      setState(() {
        _emailErrorMessage = '(!) Email cannot be empty.';
      });
      return false;
    } else if (password == null || password.isEmpty) {
      setState(() {
        _passwordErrorMessage = '(!) Password cannot be empty.';
      });
      return false;
    }
    return true;
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      if (!validateInput(email, password)) {
        return;
      } else {
        _setLoadingTrue();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Processing...')));

        try {
          final response = await http.post(
            Uri.parse('${dotenv.env['API_URL']}/Auth/Login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'password': password}),
          );

          _dismissSnackbar();
          _setLoadingFalse();
          if (response.statusCode == 200) {
            // Login successful, handle the response data
            final Map<String, dynamic> data = jsonDecode(response.body);
            // You can save the user token or other relevant data here
            print('Login successful: $data');
            // Production use this
            // Dev env pop keep data not remove like replace
            // await Navigator.pushReplacementNamed(context, '/');
            await Navigator.pushNamed(context, '/');
          } else {
            // Login failed, handle the error
            print('Login failed: ${response.statusCode} - ${response.body}');
            final Map<String, dynamic> data = jsonDecode(response.body);
            print(data['result']['message']);
            setState(() {
              _emailErrorMessage = '(!) ${data['result']['message']}.';
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login failed: ${data['result']['message']}'),
                duration: const Duration(seconds: 3),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        } catch (e) {
          // Handle any exceptions that occurred during the API call
          print('Error: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('An error occurred during login'),
              duration: Duration(seconds: 3),
            ),
          );
        }
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 96,
                      child: TextFormField(
                        autocorrect: false,
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        onChanged: (value) {
                          setState(() {
                            _emailErrorMessage = null;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          errorText: _emailErrorMessage,
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
                      height: 86,
                      child: TextFormField(
                        autocorrect: false,
                        autofocus: false,
                        controller: _passwordController,
                        onChanged: (value) {
                          setState(() {
                            _passwordErrorMessage = null;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Password',
                          errorText: _passwordErrorMessage,
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
                          Navigator.pushNamed(context, '/forgot_pw');
                        },
                        child: SizedBox(
                          height: 24,
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
                    ),
                    Padding(padding: EdgeInsets.only(top: 32), child: SizedBox(
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
                        ))),
                  ],
                )),
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 32),
                child: Column(
                  children: [
                    Text(
                      '- OR Continue With -',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: colorScheme.onSurface),
                    ),
                    Padding(padding: EdgeInsets.only(top: 32),child: GoogleLoginButton()),
                    Padding(padding: EdgeInsets.only(top: 16), child: Row(
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
                    )),
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
