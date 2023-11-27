import 'package:flutter/material.dart';
import 'package:jasper_heatlh_app/src/presentation/auth/login_controller.dart';

/// Displays detailed information about a SampleItem.
class LoginView extends StatelessWidget {
  const LoginView({super.key, required this.controller});

  static const routeName = '/login_view';

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
          child: ElevatedButton(
              child: const Text('Click to Login'),
              onPressed: () async {
                await controller.loginAnonymously();
                if (controller.isLoggedIn() && context.mounted) {
                  Navigator.restorablePushNamed(context, routeName);
                }
              }),
        ));
  }
}
