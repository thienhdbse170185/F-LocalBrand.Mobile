import 'package:f_localbrand/screens/widgets/buttons/back_button.dart';
import 'package:f_localbrand/screens/widgets/buttons/suffix_icon_button.dart';
import 'package:f_localbrand/screens/widgets/icons/icon_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../config/router.dart';
import '../../../config/themes/material_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureConfirm = true;
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _emailErrorMessage,
      _passwordErrorMessage,
      _confirmErrorMessage,
      _usernameErrorMessage;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _dismissSnackbar() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  bool validateInput(
      String? username, String? email, String? password, String? confirm) {
    if (username == null || username.isEmpty) {
      setState(() {
        _usernameErrorMessage = '(!) Email cannot be empty.';
      });
      return false;
    } else if (email == null || email.isEmpty) {
      setState(() {
        _emailErrorMessage = '(!) Username cannot be empty.';
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
    /*Comment for implement UI Register UserProfile
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();
      final String confirm = _confirmController.text.trim();
      final String username = _usernameController.text.trim();

      if (!validateInput(username, email, password, confirm)) {
        return;
      } else {
        _setLoadingTrue();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Processing...')));

        try {
          _setLoadingFalse();
          _dismissSnackbar();
        } catch (e) {
          print('Error: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('An error occurred during signup'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    }*/
    context.push(RouteName.registerUserProfile);
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
      appBar: AppBar(
        leading: CustomBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_isLoading ? 'Submitting...' : 'Register',
                        style: textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(
                        _isLoading
                            ? 'Your account is being created...'
                            : 'Please enter your details',
                        style: textTheme.displayMedium),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 96,
                    child: TextFormField(
                      autocorrect: false,
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      controller: _usernameController,
                      onChanged: (value) {
                        setState(() {
                          _usernameErrorMessage = null;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "Username",
                          errorText: _usernameErrorMessage,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 20),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          prefixIcon: IconInput(
                            icon: FaIcon(FontAwesomeIcons.solidUser),
                          )),
                      style: textTheme.bodyLarge,
                    ),
                  ),
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
                          prefixIcon: IconInput(
                            icon: FaIcon(FontAwesomeIcons.solidEnvelope),
                          )),
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
                          prefixIcon: IconInput(
                            icon: FaIcon(FontAwesomeIcons.lock),
                          ),
                          suffixIcon: SuffixIconButton(
                            onPressed: _togglePasswordVisibility,
                            icon: FaIcon(
                              _obscurePassword
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              color: MaterialTheme.lightScheme().outline,
                            ),
                          )),
                      obscureText: _obscurePassword,
                      style: textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                      height: 86,
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
                          prefixIcon: IconInput(
                            icon: FaIcon(FontAwesomeIcons.lock),
                          ),
                          suffixIcon: SuffixIconButton(
                            onPressed: _toggleConfirmVisibility,
                            icon: FaIcon(
                              _obscureConfirm
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              color: MaterialTheme.lightScheme().outline,
                            ),
                          ),
                        ),
                        obscureText: _obscureConfirm,
                        style: textTheme.bodyLarge,
                      )),
                  Padding(
                    padding: EdgeInsets.only(bottom: 36, top: 10),
                    child: Text.rich(TextSpan(children: [
                      TextSpan(
                          text: 'By clicking the ',
                          style: textTheme.bodyMedium),
                      TextSpan(
                          text: 'Register',
                          style: textTheme.bodyMedium
                              ?.copyWith(color: colorScheme.error)),
                      TextSpan(
                          text: ' button, you agree \nto the public offer',
                          style: textTheme.bodyMedium)
                    ])),
                  ),
                  SizedBox(
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
