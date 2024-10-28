import 'package:flutter/material.dart';

class AgregarEnlaceScreen extends StatelessWidget {
  const AgregarEnlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Ingresa enlaces",
            ),
          ),
        ],
      ),
    );
  }
}
