import 'dart:convert';
import 'package:fastinvoice/invoices/screens/invoice_screen.dart';
import 'package:fastinvoice/routes/app_routes.dart';
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
      // Extract token from response
      Map<String, dynamic> data = json.decode(response.body);
      String token = data['token'];
      // Navigate to InvoiceList screen and pass token as argument
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InvoiceList(token: token),
        ),
      );
    } else if (response.statusCode == 400) {
        // Bad request
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: solicitud incorrecta')),
        );
      } else if (response.statusCode == 401) {
        // Unauthorized: incorrect email or password
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Error: correo electrónico o contraseña incorrectos')),
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
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(context),
                _inputField(context),
                _forgotPassword(context),
                _signup(context),
              ],
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
          "Iniciar sesión",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Ingrese su credencial para iniciar"),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
              hintText: "Correo electrónico",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
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
              prefixIcon: const Icon(Icons.key)),
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
          onPressed: _login,
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16)),
          child: const Text("Iniciar sesión", style: TextStyle(fontSize: 20)),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return const TextButton(onPressed: null, child: Text("¿Has olvidado tu contraseña?"));
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("¿No tienes una cuenta?"),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.registerScreen),
          child: const Text("Regístrate"),
        ),
      ],
    );
  }
}
