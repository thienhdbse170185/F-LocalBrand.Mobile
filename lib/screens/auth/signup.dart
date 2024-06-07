import 'dart:convert';

import 'package:f_localbrand/screens/components/buttons/google_login.dart';
import 'package:f_localbrand/themes/custom_themes/button_theme.dart';
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
  String? _emailErrorMessage, _passwordErrorMessage, _confirmErrorMessage;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _dismissSnackbar() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  bool validateInput(String? email, String? password, String? confirm) {
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
    } else if (confirm == null || confirm.isEmpty) {
      setState(() {
        _confirmErrorMessage = '(!) Confirm cannot be empty.';
      });
      return false;
    }
    return true;
  }

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();
      final String confirm = _confirmController.text.trim();

      if (!validateInput(email, password, confirm)) {
        return;
      } else {
        _setLoadingTrue();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Processing...')));

        try {
          /* Uncomment when API is ready
          final response = await http.post(
            Uri.parse('${dotenv.env['API_URL']}/Auth/Signup'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'password': password}),
          );

          _dismissSnackbar();
          _setLoadingFalse();
          if (response.statusCode == 200) {
            // Login successful, handle the response data
            final Map<String, dynamic> data = jsonDecode(response.body);
            // You can save the user token or other relevant data here
            print('Signup successful: $data');
            // Production use this
            // Dev env pop keep data not remove like replace
            // await Navigator.pushReplacementNamed(context, '/');
            await Navigator.pushNamed(context, '/');
          } else {
            // Login failed, handle the error
            print('Signup failed: ${response.statusCode} - ${response.body}');
            final Map<String, dynamic> data = jsonDecode(response.body);
            print(data['result']['message']);
            setState(() {
              _emailErrorMessage = '(!) ${data['result']['message']}.';
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Signup failed: ${data['result']['message']}'),
                duration: const Duration(seconds: 3),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          } */

          _setLoadingFalse();
          _dismissSnackbar();
        } catch (e) {
          // Handle any exceptions that occurred during the API call
          print('Error: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('An error occurred during signup'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
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
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _resetSignupState();
  }

  void _resetSignupState() {
    setState(() {
      _emailController.clear();
      _passwordController.clear();
      _obscurePassword = true;
      _obscureConfirm = true;
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
        padding: const EdgeInsets.only(top: 72, right: 36, left: 36),
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
                    height: 96,
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
                            _obscurePassword
                                ? Ionicons.eye_off_outline
                                : Ionicons.eye_outline,
                          ),
                        ),
                      ),
                      obscureText: _obscurePassword,
                      style: textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                      height: 96,
                      child: TextFormField(
                        autocorrect: false,
                        autofocus: false,
                        controller: _confirmController,
                        onChanged: (value) {
                          setState(() {
                            _confirmErrorMessage = null;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          errorText: _confirmErrorMessage,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 19),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
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
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _signup,
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
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 36),
                child: Column(
                  children: [
                    Text(
                      '- OR Continue With -',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: colorScheme.onSurface),
                    ),
                    GoogleLoginButton(),
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
