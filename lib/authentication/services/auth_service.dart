import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  String errorMessage = '';

  Future<String> login(String email, String password) async {
    var url = Uri.parse('http://10.0.2.2:8000/v1/login');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'correo': email,
          'password': password,
        }));

    if (response.statusCode == 200) {
      // Login successful
      // Extract token from response
      Map<String, dynamic> data = json.decode(response.body);
      String token = data['token'];
      return token;
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
    var url = Uri.parse('http://10.0.2.2:8000/v1/register');
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
}
