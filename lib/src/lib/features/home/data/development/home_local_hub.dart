import 'dart:async';

import 'package:blog_app/src/lib/features/app/domain/models/spoileable.dart';
import 'package:blog_app/src/lib/features/home/domain/hub/ihome_portadas_hub.dart';
import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:blog_app/src/lib/features/media/domain/models/media.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class HomeLocalHub extends IHomePortadasHub {
  static const uuid = Uuid();
  @override
  void onHiloCreado(OnHiloCreado on) {
    Timer.periodic(
      const Duration(seconds: 10),
      (timer) => on(
        HomePortada(
          id: uuid.v4(),
          titulo: "Pepito",
          categoria: "NSFW",
          features: const [HomePortadaFeatures.sticky],
          ultimoBump: DateTime.now(),
          imagen: const Spoileable(
            true,
            Imagen(
              provider: NetworkProvider(
                path:
                    "https://s201.erome.com/1467/xpM0lLFN/gTt5OlKt.jpeg?v=1702625248",
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onHiloEliminado(OnHiloEliminado on) {
    // TODO: implement onHiloEliminado
  }
}
