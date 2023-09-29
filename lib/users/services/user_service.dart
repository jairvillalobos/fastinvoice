// lib/users/services/user_service.dart
import 'package:fastinvoice/authentication/services/auth_service.dart';
import 'package:fastinvoice/constants/api_endpoints.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final AuthService _authService = AuthService();

  Future getUserInfo() async {
    var url = Uri.parse(ApiEndpoints.userProfile);
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_authService.token}',
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error al obtener la información del usuario');
    }
  }
}
