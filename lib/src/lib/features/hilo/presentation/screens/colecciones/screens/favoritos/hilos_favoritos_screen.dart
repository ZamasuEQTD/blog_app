import 'package:flutter/material.dart';

class HilosFavoritosScreen extends StatelessWidget {
  const HilosFavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hilos favoritos"),
      ),
      body: const CustomScrollView(
        slivers: [],
      ),
    );
  }
}
