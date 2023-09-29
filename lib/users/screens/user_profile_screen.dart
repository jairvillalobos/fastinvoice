// lib/users/screens/user_profile_screen.dart
import 'package:fastinvoice/authentication/services/auth_service.dart';
import 'package:fastinvoice/users/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:fastinvoice/users/widgets/user_profile_widget.dart';
import 'package:fastinvoice/models/user.dart'; // Asegúrate de importar tu modelo User
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class UserProfileScreen extends StatelessWidget {
  final UserService userService = UserService();
  AuthService authService = AuthService();

  final String token;

  UserProfileScreen({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == null) {
          return const Text('Por favor inicia sesión para ver esta página');
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Perfil del usuario'),
            ),
            body: FutureBuilder(
              future: userService.getUserInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  var data = snapshot.data;
                  var user =
                      User.fromMap(data); // Convierte el mapa en un objeto User
                  return Column(
                    children: <Widget>[
                      UserProfileWidget(user: user),
                    ],
                  );
                }
              },
            ),
          );
        }
      },
    );
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
