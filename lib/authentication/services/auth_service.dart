import 'dart:convert';
import 'package:fastinvoice/constants/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();

  factory AuthService() {
    return _singleton;
  }

  AuthService._internal();

  String _token = '';

  String get token => _token;

  String errorMessage = '';

  Future<String> login(String email, String password) async {
    var url = Uri.parse(ApiEndpoints.login);
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'correo': email,
          'password': password,
        }));

    if (response.statusCode == 200) {
      // Login successful
      // Extract token from response
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token);
      
      Map<String, dynamic> data = json.decode(response.body);
      _token = data['token'];
      return _token;
    } else if (response.statusCode == 400) {
      // Bad request
      throw Exception('Error: solicitud incorrecta');
    } else if (response.statusCode == 401) {
      // Unauthorized: incorrect email or password
      throw Exception(
          'Error: correo electrónico o contraseña incorrectos');
    } else {
      // Other server error
      throw Exception('Server error: ${response.statusCode}');
    }
  }

  Future<bool> register(String username, String email, String password) async {
    var url = Uri.parse(ApiEndpoints.register);
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nombre_usuario': username,
          'correo': email,
          'password': password,
        }));

    if (response.statusCode == 201) {
      // Registro exitoso
      return true;
    } else if (response.statusCode == 400) {
      // Solicitud incorrecta
      errorMessage = 'Error: Solicitud incorrecta';
    } else if (response.statusCode == 409) {
      // Conflicto: el usuario ya existe
      errorMessage = 'Error: El usuario ya existe';
    } else {
      // Otro error del servidor
      errorMessage = 'Error del servidor: ${response.statusCode}';
    }
    return false;
  }

  Future<void> logout() async {
    var url = Uri.parse(ApiEndpoints.logout);
    try {
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_token',
          });

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
        _token = ''; // Limpia el token en memoria
      } else {
        // Otro error del servidor
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage = 'Error al cerrar sesión: $e';
      rethrow;
    }
  }

}
