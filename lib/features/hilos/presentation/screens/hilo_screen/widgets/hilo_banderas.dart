import 'dart:collection';

import 'package:blog_app/features/hilos/presentation/widgets/icons/hilo_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../app/presentation/widgets/outlined_icon.dart';
import '../../../../domain/models/hilo.dart';

class HiloBanderas extends StatelessWidget {
  static final HashMap<BanderasDeHilo, Widget> _banderas = HashMap.from({
    BanderasDeHilo.dados: const HiloIcon.dados(),
    BanderasDeHilo.encuesta: const HiloIcon.encuesta(),
    BanderasDeHilo.sticky: const HiloIcon.destacado(),
    BanderasDeHilo.idUnico: const HiloIcon.idUnico(),
  });

  const HiloBanderas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Hilo hilo = context.read();

    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          const BackButton(),
          ...hilo.banderas.map(
            (bandera) => SizedBox(
              height: 30,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: OutlinedIcon(
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: FittedBox(child: _banderas[bandera]!),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
