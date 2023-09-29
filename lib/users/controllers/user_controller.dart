// lib/users/controllers/user_controller.dart
import 'package:fastinvoice/models/user.dart';
import 'package:flutter/material.dart';
import '../services/user_service.dart';

class UserController with ChangeNotifier {
  final UserService userService = UserService();

  Future<User> getUserInfo() async {
    try {
      User user = await userService.getUserInfo();
      return user;
    } catch (e) {
      throw Exception('Error al obtener la información del usuario');
    }
  }
}
