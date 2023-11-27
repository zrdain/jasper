import 'package:firebase_auth/firebase_auth.dart';

/// A service that deals with various login functions and retrieving current user data
class LoginService {
  /// Loads the User's credentials from Firebase
  Future<UserCredential>? loginAnonymously() async => FirebaseAuth.instance.signInAnonymously();

  /// Logs out the current user
  Future<void> logout() async {
    if(isLoggedIn()) FirebaseAuth.instance.signOut();
  }

  /// Persists the user's preferred ThemeMode to local or remote storage.
  User? currentUser() => FirebaseAuth.instance.currentUser;

  /// Check to see if the user is logged in or not
  bool isLoggedIn() => currentUser() != null;
}
