import 'package:fastinvoice/authentication/services/auth_service.dart';

class RegisterController {
  final _authService = AuthService();
  String errorMessage = '';

  Future<bool> register(String username, String email, String password) async {
    bool success = await _authService.register(username, email, password);
    errorMessage = _authService.errorMessage;
    return success;
  }
}
