import 'package:flutter/material.dart';

import '../../../../../../../../../../domain/features/hilos/models/hilo.dart';
import '../../../../../../../../../common/widgets/tags/outlined_text_tag.dart';

class DatosDeCreacionDeHilo extends StatelessWidget {
  final Hilo hilo;
  const DatosDeCreacionDeHilo({
    super.key,
    required this.hilo
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const NombreDeCreadorDeHilo(nombre: "Gear",),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: const OutlinedTag(
            texto: "MOD",
          ),
        ),
        // CreadoHace(createdAt: hilo.createdAt)
      ],
    );
  }
}


class NombreDeCreadorDeHilo extends StatelessWidget {
  final String nombre;
  const NombreDeCreadorDeHilo({
    super.key, 
    required this.nombre,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      nombre,
      style: const TextStyle(fontWeight: FontWeight.w600),
    );
  }
}
