import 'package:f_localbrand/config/router.dart';
import 'package:f_localbrand/config/themes/custom_themes/index.dart';
import 'package:f_localbrand/screens/widgets/buttons/google_login.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 72, left: 36, right: 36),
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/images/Saly-22.png'),
              height: 280,
              width: 280,
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      'Let\'s get started!',
                      style: FTextTheme.light.titleSmall,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Text(
                      'Signup or log into your account',
                      style: FTextTheme.light.displayMedium,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 36),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      context.go(RouteName.login);
                    },
                    child: Text('CONTINUE WITH EMAIL',
                        style: FTextTheme.light.headlineSmall
                            ?.copyWith(color: Colors.white, fontSize: 14)),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: GoogleLoginButton(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 36),
              child: Text(
                'Are you new here?',
                style: FTextTheme.light.bodyMedium,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 36),
              child: GestureDetector(
                onTap: () {
                  context.go(RouteName.register);
                },
                child: Text('Create an account',
                    style: FTextTheme.light.headlineSmall
                        ?.copyWith(color: Theme.of(context).primaryColor)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
