import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final String text;
  final String routeName;

  const Login({
    Key? key,
    required this.text,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(text),
      TextButton(
          onPressed: () => Navigator.pushNamed(context, routeName),
          child: const Text("Inicia sesión"))
    ]);
  }
}
