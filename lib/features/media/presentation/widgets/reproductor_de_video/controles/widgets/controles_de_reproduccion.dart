import 'package:flutter/material.dart';

import 'control/reproductor_control_icon.dart';

class AccionesDeReproductor extends StatelessWidget {
  const AccionesDeReproductor({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ReproductorDeVideoControl.icon(
          onTap: () {},
          icon: Icons.volume_off_rounded,
          size: 40,
        ),
        const SizedBox(width: 10),
        ReproductorDeVideoControl.icon(
          onTap: () {},
          icon: Icons.fullscreen,
          size: 40,
        ),
      ],
    );
  }
}
