import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Text(
          "¡Bienvenido!",
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
