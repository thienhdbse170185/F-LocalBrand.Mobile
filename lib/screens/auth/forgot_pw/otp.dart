import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});
  @override
  State<StatefulWidget> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final elevatedButtonTheme = Theme.of(context).elevatedButtonTheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: EdgeInsets.only(top: 72, right: 36, left: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("OTP Verification",
                  style: Theme.of(context).textTheme.titleMedium),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Enter the verification code we just sent you on your email address.",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: colorScheme.outline),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 48),
                child: OtpTextField(
                  numberOfFields: 4,
                  focusedBorderColor: colorScheme.primary,
                  textStyle: textTheme.headlineMedium,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  borderWidth: 1,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  showFieldAsBox: true,
                  fieldWidth: 64,
                  onSubmit: (String code) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Verification Code"),
                            content: Text('Code entered is $code'),
                          );
                        });
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 64),
                  child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: elevatedButtonTheme.style,
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : Text(
                                'Verify',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                      ))),
              Padding(
                  padding: EdgeInsets.only(top: 64),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Resend OTP in 23s',
                          style: textTheme.bodyLarge,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Resend OTP',
                              style: textTheme.headlineSmall?.copyWith(
                                color: colorScheme.primary,
                              ),
                            ))
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}
