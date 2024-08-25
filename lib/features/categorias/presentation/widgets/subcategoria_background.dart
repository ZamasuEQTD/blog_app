import 'package:flutter/material.dart';

class SubcategoriaBackground extends StatelessWidget {
  final Widget child;
  const SubcategoriaBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: child,
        ),
      ),
    );
  }
}

class SubcategoriaImagen extends StatelessWidget {
  final ImageProvider provider;
  const SubcategoriaImagen({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: Image(image: provider, fit: BoxFit.cover),
    );
  }
}
