import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 44.0, horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back,',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Discover Limitless Choices and Unmatched Convenience.',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              TextFormField(
                autocorrect: false,
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: "Username",
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: Colors.black)),
                    prefixIcon: Icon(Ionicons.person)),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 24),
              TextFormField(
                  autocorrect: false,
                  autofocus: false,
                  decoration: const InputDecoration(
                      hintText: 'Password',
                      contentPadding: EdgeInsets.symmetric(vertical: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: Icon(Ionicons.lock_closed),
                      suffixIcon: IconButton(
                        onPressed: null,
                        icon: Icon(Ionicons.eye_outline),
                        style: ButtonStyle(
                            iconColor: WidgetStatePropertyAll(Colors.black87)),
                      )),
                  obscureText: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  )),
              TextButton(
                onPressed: null,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: null,
                style: Theme.of(context).elevatedButtonTheme.style,
                child: const Text('Sign In'),
              )
            ],
          ),
        ));
  }
}
