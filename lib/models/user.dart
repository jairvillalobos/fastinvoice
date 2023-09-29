// lib/models/user.dart
class User {
  final String username;
  final String email;
  final String role;

  User({required this.username, required this.email, required this.role});

  // Método para convertir un mapa en un objeto User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['nombre_usuario'],
      email: map['correo'],
      role: map['role'],
    );
  }
}
