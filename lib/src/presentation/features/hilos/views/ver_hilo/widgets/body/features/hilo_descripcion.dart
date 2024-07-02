import 'package:flutter/material.dart';

class HiloDescripcion extends StatelessWidget {
  final String descripcion;
  const HiloDescripcion({super.key, required this.descripcion});

  @override
  Widget build(BuildContext context) {
    return Text(
      descripcion,
      style: getStyle(),
    );
  }

  getStyle() {
    return const TextStyle(fontSize: 18);
  }
}
