import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jasper_heatlh_app/src/presentation/auth/login_controller.dart';
import 'package:jasper_heatlh_app/src/presentation/auth/login_service.dart';

import 'src/app.dart';
import 'firebase_options.dart';
import 'src/presentation/settings/settings_controller.dart';
import 'src/presentation/settings/settings_service.dart';

void main() async {
  // Load up Firebase so we can make calls to our server
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());
  final loginController = LoginController(LoginService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(
      settingsController: settingsController,
      loginController: loginController));
}
