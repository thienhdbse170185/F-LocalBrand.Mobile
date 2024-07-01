import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  String? _emailErrorMessage;

  final _formKey = GlobalKey<FormState>();

  Future<void> _sendRecoveryEmail() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text.trim();
      if (email.isEmpty) {
        setState(() {
          _emailErrorMessage = '(!) Email cannot be empty.';
        });
        return;
      } else if (!EmailValidator.validate(email)) {
        setState(() {
          _emailErrorMessage = '(!) Invalid email address.';
        });
        return;
      }
      setState(() {
        _emailErrorMessage = null;
        _isLoading = true;
      });
      try {
        await http.post(
          Uri.parse(
              'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=${dotenv.env['API_KEY']}'),
          body: {
            'requestType': 'PASSWORD_RESET',
            'email': email,
          },
        );
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Email sent!')));
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
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
            children: [
              SizedBox(
                height: 120,
                child:
                    Text(_isLoading ? 'Sending...' : 'Forgot \npassword?',
                        style: textTheme.titleMedium),

                ),
              SizedBox(
                height: 70,
                child: Text(
                    _isLoading
                        ? 'Sending to your recovery email...'
                        : 'Please enter your \nrecovery email address',
                    style: textTheme.displayMedium),
              ),
              Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            errorStyle: textTheme.displayMedium?.copyWith(
                              color: colorScheme.error,
                              fontSize: 10
                            ),
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
                            prefixIcon: const Icon(Ionicons.mail),
                          ),
                          style: textTheme.bodyLarge,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 24),
                        child: Text.rich(TextSpan(children: [
                          TextSpan(
                              text: '*',
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: colorScheme.error)),
                          TextSpan(
                              text:
                                  ' We will send you a message to set or reset \nyour new password',
                              style: textTheme.bodyMedium)
                        ])),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _sendRecoveryEmail,
                              style: elevatedButtonTheme.style,
                              child: _isLoading
                                  ? const CircularProgressIndicator()
                                  : Text(
                                      'Submit',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(color: Colors.white),
                                    ),
                            )),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}
