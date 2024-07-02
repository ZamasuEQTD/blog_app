import 'package:flutter/material.dart';

import '../../../../../../../../../domain/features/hilos/models/hilo.dart';
import 'acciones_de_hilo/acciones_de_hilo.dart';
import 'datos_de_creacion/datos_de_creacion_de_hilo.dart';

class AccionesDeHiloBar extends StatelessWidget {
  final Hilo hilo;
  const AccionesDeHiloBar({super.key, required this.hilo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AccionesDeHilo(hilo: hilo),
          DatosDeCreacionDeHilo(hilo: hilo)
        ],
      ),
    );
  }
}

 
