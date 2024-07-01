import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  @override
  State<StatefulWidget> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;

  final _newPasswordController = TextEditingController();
  final _confirmController = TextEditingController();
  String? _newPasswordErrorMessage, _confirmErrorMessage;

  bool _obscureConfirm = true;
  bool _obscurePassword = true;

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

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      _setLoadingTrue();
      _formKey.currentState!.save();
      await Future.delayed(const Duration(seconds: 2));
      _setLoadingFalse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final elevatedButtonTheme = Theme.of(context).elevatedButtonTheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 72, right: 36, left: 36, bottom: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                SizedBox(
                  height: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_isLoading ? 'Reseting...' : 'Reset Password',
                          style: textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(
                          _isLoading
                              ? 'Resetting your password...'
                              : 'Enter your new password twice below to reset a new password',
                          style: textTheme.displayMedium),
                    ],
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
                          controller: _newPasswordController,
                          onChanged: (value) {
                            setState(() {
                              _newPasswordErrorMessage = null;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'New password',
                            errorText: _newPasswordErrorMessage,
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
                              hintText: 'Re-enter new password',
                              errorText: _confirmErrorMessage,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 19),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
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
                        padding: EdgeInsets.only(top: 32),
                        child: SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _resetPassword,
                            style: elevatedButtonTheme.style,
                            child: _isLoading
                                ? const CircularProgressIndicator()
                                : Text(
                                    'Reset Password',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(color: Colors.white),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            TextButton(
              onPressed: () {
                // Xử lý khi người dùng nhấn "Create an Account"
                print('Create an Account');
              },
              child: Text(
                'Create an Account',
                style: textTheme.headlineSmall?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
