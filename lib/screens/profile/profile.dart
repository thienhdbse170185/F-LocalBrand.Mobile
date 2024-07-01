import 'package:f_localbrand/config/router.dart';
import 'package:f_localbrand/config/themes/custom_themes/index.dart';
import 'package:f_localbrand/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthLogoutSuccess():
            context.go(RouteName.getStarted);
            break;
          default:
            break;
        }
      },
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.only(top: 64),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'My Profile',
                    style: FTextTheme.light.titleSmall,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthLogoutStarted());
                      },
                      child: Text(
                        'Logout',
                        style: FTextTheme.light.displayMedium,
                      ))
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
