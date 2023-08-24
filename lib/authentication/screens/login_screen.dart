import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      var url = Uri.parse('http://10.0.2.2:8000/v1/login');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'correo': _emailController.text,
            'password': _passwordController.text,
          }));

      if (!mounted) return;

      if (response.statusCode == 200) {
        // Login successful
        // For example, display a success message and redirect the user to the home screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inicio de sesión exitoso')),
        );
        //Navigator.pushNamed(context, '/home');
      } else if (response.statusCode == 400) {
        // Bad request
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: solicitud incorrecta')),
        );
      } else if (response.statusCode == 401) {
        // Unauthorized: incorrect email or password
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: correo electrónico o contraseña incorrectos')),
        );
      } else {
        // Other server error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration:
                    const InputDecoration(labelText: 'Correo electrónico'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingrese su correo electrónico';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingrese su contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Iniciar sesión'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child:
                    const Text('¿No tienes una cuenta? Registrate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
