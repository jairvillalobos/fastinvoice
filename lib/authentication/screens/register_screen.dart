import 'dart:convert';
import 'package:fastinvoice/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _register() async {
    if (_formKey.currentState!.validate()) {
      var url = Uri.parse('http://10.0.2.2:8000/v1/register');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'nombre_usuario': _usernameController.text,
            'correo': _emailController.text,
            'password': _passwordController.text,
          }));

      if (!mounted) return;

      if (response.statusCode == 201) {
        // Registro exitoso
        // Por ejemplo, mostrar un mensaje de éxito y redirigir al usuario a la pantalla de inicio de sesión
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registro exitoso')),
        );
        Navigator.pushNamed(context, AppRoutes.loginScreen);
      } else if (response.statusCode == 400) {
        // Solicitud incorrecta
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: Solicitud incorrecta')),
        );
      } else if (response.statusCode == 409) {
        // Conflicto: el usuario ya existe
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: El usuario ya existe')),
        );
      } else {
        // Otro error del servidor
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error del servidor: ${response.statusCode}')),
        );
      }
    }
  }

 @override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(context),
                const SizedBox(height: 100), // Add space between header and input fields
                _inputField(context),
                _signup(context),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}


  _header(context) {
    return const Column(
      children: [
        Text(
          "Registro",
          style: TextStyle(fontSize: 40,  fontWeight: FontWeight.bold),
        ),
        Text("Ingresa tus datos para registrarte"),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
              hintText: "Nombre de usuario",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Por favor ingrese su nombre de usuario';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
              hintText: "Correo electrónico",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.email)),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Por favor ingrese su correo electrónico';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
              hintText: "Contraseña",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.lock)),
          obscureText: true,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Por favor ingrese su contraseña';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: _register,
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16)),
            child: const Text("Registrarse", style: TextStyle(fontSize: 20))),
      ],
    );
  }

  _signup(context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("¿Ya tienes una cuenta? "),
      TextButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.loginScreen),
          child: const Text("Inicia sesión"))
    ]);
  }
}
