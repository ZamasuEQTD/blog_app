import 'package:flutter/material.dart';

import '../../../../../../../../../../domain/features/hilos/models/hilo.dart';
import 'accion_de_hilo_btn.dart';

class AccionesDeHilo extends StatelessWidget {
  final Hilo hilo;
  const AccionesDeHilo({
    super.key, required this.hilo,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        AccionDeHiloBtn(iconData: Icons.safety_check),
        AccionDeHiloBtn(iconData: Icons.star_outline),
        AccionDeHiloBtn(iconData: Icons.safety_check),
        AccionDeHiloBtn(iconData: Icons.safety_check)
      ],
    );
  }
}
