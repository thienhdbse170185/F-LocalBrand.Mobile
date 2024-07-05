import 'package:f_localbrand/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../config/router.dart';

class GoogleLoginButton extends StatefulWidget {
  const GoogleLoginButton({super.key});

  @override
  State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  bool _isLoading = false;

  Future<void> _loginWithGoogle() async {
    context.read<AuthBloc>().add(AuthLoginGoogleStarted());
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthLoginFailure(message: final msg):
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login failed: $msg'),
                duration: const Duration(seconds: 3),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
            break;
          // TODO: Handle this case.
          case AuthLoginInProgress():
            setState(() {
              _isLoading = true;
            });
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Progressing...')));
            break;
          case AuthLoginSuccess():
            // TODO: Handle this case.
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Login successfully!"),
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
      child: SizedBox(
        height: 48,
        child: OutlinedButton(
          onPressed: _loginWithGoogle,
          child: _isLoading
              ? CircularProgressIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 10.0,
                      child: Image(
                        image: AssetImage('assets/icon/google.png'),
                        width: 32.0,
                        height: 32.0,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'CONTINUE WITH GOOGLE',
                      style: textTheme.headlineSmall?.copyWith(fontSize: 14),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
