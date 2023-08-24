import 'package:fastinvoice/authentication/screens/login_screen.dart';
import 'package:flutter/material.dart';
import './authentication/screens/register_screen.dart'; // Importa tu componente aquí

void main() => runApp(const FastInvoice());

class FastInvoice extends StatelessWidget {
  const FastInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FastInvoice',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}