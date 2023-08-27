import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController? usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback? onLoginPressed;
  final VoidCallback? onRegisterPressed;

  const InputField({
    Key? key,
    this.usernameController,
    required this.emailController,
    required this.passwordController,
    this.onLoginPressed,
    this.onRegisterPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (usernameController != null)
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
                hintText: "Nombre de usuario",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor:
                    Theme.of(context).primaryColor.withOpacity(0.1),
                filled: true,
                prefixIcon:
                    const Icon(Icons.person)),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese su nombre de usuario';
              }
              return null;
            },
          ),
        if (usernameController != null) const SizedBox(height: 10),
        TextFormField(
          controller:
              emailController,
          decoration:
              InputDecoration(
                  hintText:
                      "Correo electrónico",
                  border:
                      OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(18),
                          borderSide:
                              BorderSide.none),
                  fillColor:
                      Theme.of(context)
                          .primaryColor
                          .withOpacity(0.1),
                  filled:
                      true,
                  prefixIcon:
                      const Icon(Icons.email)),
          validator:
              (value) {
            if (value!.isEmpty) {
              return 'Por favor ingrese su correo electrónico';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller:
              passwordController,
          decoration:
              InputDecoration(
                  hintText:
                      "Contraseña",
                  border:
                      OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(18),
                          borderSide:
                              BorderSide.none),
                  fillColor:
                      Theme.of(context)
                          .primaryColor
                          .withOpacity(0.1),
                  filled:
                      true,
                  prefixIcon:
                      const Icon(Icons.lock)),
          obscureText:
              true,
          validator:
              (value) {
            if (value!.isEmpty) {
              return 'Por favor ingrese su contraseña';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        if (onLoginPressed != null)
          ElevatedButton(
            onPressed: onLoginPressed,
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16)),
            child: const Text("Iniciar sesión", style: TextStyle(fontSize: 20)),
          ),
        if (onRegisterPressed != null)
          ElevatedButton(
            onPressed: onRegisterPressed,
            style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(vertical: 16)),
            child: const Text("Registrarse", style: TextStyle(fontSize: 20)),
          ),
      ],
    );
  }
}
