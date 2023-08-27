import 'package:fastinvoice/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:fastinvoice/authentication/widgets/header.dart';
import 'package:fastinvoice/authentication/widgets/input_field.dart';
import 'package:fastinvoice/authentication/widgets/signup.dart';
import 'package:fastinvoice/authentication/controllers/register_controller.dart';

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
  final _registerController = RegisterController();

  void _register() async {
    if (_formKey.currentState!.validate()) {
      bool success = await _registerController.register(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
      );
      if (!mounted) return;
      if (success) {
        // Registro exitoso
        // Por ejemplo, mostrar un mensaje de éxito y redirigir al usuario a la pantalla de inicio de sesión
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registro exitoso')),
        );
        Navigator.pushNamed(context, AppRoutes.loginScreen);
      } else {
        // Registro fallido
        // Por ejemplo, mostrar un mensaje de error
        final snackBar =
            SnackBar(content: Text(_registerController.errorMessage));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                  const Header(
                    title: 'Registro',
                    subtitle: 'Ingresa tus datos para registrarte',
                  ),
                  InputField(
                    usernameController: _usernameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    onRegisterPressed: _register,
                  ),
                  const Signup(
                    text: '¿Ya tienes una cuenta? ',
                    routeName: AppRoutes.loginScreen,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
