import 'package:fastinvoice/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:fastinvoice/authentication/controllers/login_controller.dart';
import 'package:fastinvoice/authentication/widgets/header.dart';
import 'package:fastinvoice/authentication/widgets/input_field.dart';
import 'package:fastinvoice/authentication/widgets/forgot_password.dart';
import 'package:fastinvoice/authentication/widgets/signup.dart';
import 'package:fastinvoice/invoices/screens/invoice_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginController = LoginController();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      bool success = await _loginController.login(
        _emailController.text,
        _passwordController.text,
      );
      if (!mounted) return;
      if (success) {
        // Login successful
        // For example, display a success message and redirect the user to the home screen
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => InvoiceList(token: _loginController.token),
          ),
        );
      } else {
        // Login failed
        // For example, display an error message
        final snackBar = SnackBar(content: Text(_loginController.errorMessage));
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Header(
                  title: 'Iniciar sesión',
                  subtitle: 'Ingrese su credencial para iniciar',
                ),
                InputField(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  onLoginPressed: _login,
                ),
                const ForgotPassword(),
                const Signup(
                  text: '¿No tienes una cuenta? ',
                  routeName: AppRoutes.registerScreen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
