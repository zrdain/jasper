import 'package:flutter/material.dart';
import 'package:jasper_heatlh_app/src/presentation/auth/login_controller.dart';
import 'package:jasper_heatlh_app/src/presentation/auth/login_view.dart';

import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.settingsController, required this.loginController});

  static const routeName = '/settings';

  final SettingsController settingsController;
  final LoginController loginController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: Center(child: ElevatedButton(
              child: const Text('Logout'),
              onPressed: () async {
                await loginController.logout();
                Navigator.pushNamedAndRemoveUntil(context, LoginView.routeName, (r) => false);
              })),
      ),
    );
  }
}
