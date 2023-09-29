import 'package:fastinvoice/authentication/services/auth_service.dart';

class LogoutController {
  final _authService = AuthService();
  String errorMessage = '';

  Future<bool> logout() async {
    try {
      await _authService.logout();
      return true;
    } catch (e) {
      errorMessage = 'Error al cerrar sesión: $e';
      return false;
    }
  }
}
