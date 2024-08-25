import 'package:flutter/material.dart';

class AuthBtn extends StatelessWidget {
  final String texto;
  final void Function() onPressed;
  const AuthBtn({super.key, required this.texto, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 45,
        child: ElevatedButton(onPressed: onPressed, child: Text(texto)),
      ),
    );
  }
}
