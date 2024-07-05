import 'package:f_localbrand/config/router.dart';
import 'package:f_localbrand/screens/widgets/buttons/suffix_icon_button.dart';
import 'package:f_localbrand/screens/widgets/icons/icon_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../config/themes/material_theme.dart';
import '../../../features/auth/bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _isLoading = false;
  String? _usernameErrorMessage, _passwordErrorMessage;

  final String loginFailureMessage = 'Username or Password is not valid!';
  final String loginSuccessMessage = 'Login Successfully!';

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool validateInput(String? email, String? password) {
    if (email == null || email.isEmpty) {
      setState(() {
        _usernameErrorMessage = '(!) Username cannot be empty.';
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

  /*Login with bloc*/
  void _handleLogin(BuildContext context) {
    if (_formKey.currentState!.validate() &&
        validateInput(_usernameController.text, _passwordController.text)) {
      _setLoadingTrue();
      context.read<AuthBloc>().add(AuthLoginStarted(
          username: _usernameController.text,
          password: _passwordController.text));
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
    _usernameController.dispose();
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
      _usernameController.clear();
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

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthLoginFailure(message: final msg):
            _setLoadingFalse();
            setState(() {
              _usernameErrorMessage = loginFailureMessage;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login failed: $loginFailureMessage'),
                duration: const Duration(seconds: 3),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
            break;
          case AuthLoginInProgress():
            _setLoadingTrue();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Progressing...')));
            break;
          case AuthLoginSuccess():
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(loginSuccessMessage),
              duration: const Duration(seconds: 3),
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ));
            context.read<AuthBloc>().add(AuthAuthenticateStarted());
            break;
          case AuthAuthenticateSuccess():
            context.go(RouteName.home);
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(top: 56, right: 36, left: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  context.go(RouteName.getStarted);
                },
                icon: FaIcon(FontAwesomeIcons.arrowLeft),
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  side: BorderSide(
                      color: MaterialTheme.lightScheme().outline, width: 1),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                            _isLoading ? 'Logging in...' : 'Welcome back,',
                            style: textTheme.titleLarge),
                      ),
                      Text(
                          _isLoading
                              ? 'Please wait...'
                              : 'Discover Limitless Choices and Unmatched Convenience.',
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
                    children: <Widget>[
                      SizedBox(
                        height: 106,
                        child: TextFormField(
                          autocorrect: false,
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          controller: _usernameController,
                          onChanged: (value) {
                            setState(() {
                              _usernameErrorMessage = null;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: "Username",
                              errorText: _usernameErrorMessage,
                              errorStyle: textTheme.bodySmall
                                  ?.copyWith(color: colorScheme.error),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 20),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              prefixIcon: IconInput(
                                icon: FaIcon(FontAwesomeIcons.solidUser),
                              )),
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
                            errorStyle: textTheme.bodySmall
                                ?.copyWith(color: colorScheme.error),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 20),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            prefixIcon: IconInput(
                              icon: FaIcon(FontAwesomeIcons.lock),
                            ),
                            suffixIcon: SuffixIconButton(
                              onPressed: _togglePasswordVisibility,
                              icon: FaIcon(_obscureText
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash),
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
                            context.go(RouteName.forgotPw);
                          },
                          child: SizedBox(
                            height: 24,
                            child: Text(
                              'Forgot Password?',
                              textAlign: TextAlign.right,
                              style: textTheme.displaySmall?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 32),
                          child: SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {
                                  _isLoading ? null : _handleLogin(context);
                                },
                                style: elevatedButtonTheme.style,
                                child: _isLoading
                                    ? SizedBox(
                                        height: 32,
                                        width: 32,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
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
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: textTheme.displaySmall,
                        ),
                        TextButton(
                          onPressed: () {
                            context.go(RouteName.register);
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
