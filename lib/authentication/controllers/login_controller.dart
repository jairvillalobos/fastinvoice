import 'package:fastinvoice/authentication/services/auth_service.dart';

class LoginController {
  final _authService = AuthService();
  String token = '';
  String errorMessage = '';

  Future<bool> login(String email, String password) async {
    try {
      token = await _authService.login(email, password);
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    }
  }
}
