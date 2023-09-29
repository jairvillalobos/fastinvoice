import 'package:fastinvoice/authentication/screens/login_screen.dart';
import 'package:fastinvoice/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fastinvoice/authentication/controllers/logout_controller.dart'; // Importa tu controlador de cierre de sesión

class UserProfileWidget extends StatelessWidget {
  final User user;
  final LogoutController _logoutController = LogoutController(); // Crea una instancia de tu controlador de cierre de sesión

  UserProfileWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Text(user.username[0]),
              ),
              title: Text(user.username),
              subtitle: Text('Nombre de usuario'),
            ),
            const Divider(),
            ListTile(
              title: Text(user.email),
              subtitle: Text('Correo electrónico'),
            ),
            const Divider(),
            ListTile(
              title: Text(user.role),
              subtitle: Text('Rol'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _logoutController.logout().then((success) {
                  if (success) {
                    // Navega al usuario a la pantalla de inicio de sesión
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  } else {
                    // Muestra un mensaje al usuario
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Error al cerrar sesión'),
                      ),
                    );
                  }
                });
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
