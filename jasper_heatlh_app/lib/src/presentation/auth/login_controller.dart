import 'package:firebase_auth/firebase_auth.dart';
import 'package:jasper_heatlh_app/src/presentation/auth/login_service.dart';

class LoginController {
  LoginController(this._loginService);

  final LoginService _loginService;

  Future<void> loginAnonymously() async {
    try {
      await _loginService.loginAnonymously();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  User? getCurrentUser() {
    return _loginService.currentUser();
  }

  bool isLoggedIn() {
    return _loginService.isLoggedIn();
  }

  Future<void> logout() async {
    await _loginService.logout();
  }
  
}