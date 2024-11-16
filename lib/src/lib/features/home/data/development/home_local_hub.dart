import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:blog_app/src/lib/features/app/domain/models/spoileable.dart';
import 'package:blog_app/src/lib/features/home/domain/hub/ihome_portadas_hub.dart';
import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:blog_app/src/lib/features/media/domain/models/media.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class HomeLocalHub extends IPortadasHub {
  final HashSet<String> portadas = HashSet();
  static Random random = Random();
  static const uuid = Uuid();

  final _newPortadaController = StreamController<Portada>.broadcast();
  final _portadaDeletedController = StreamController<String>.broadcast();

  @override
  Stream<Portada> get onHiloPosteado => _newPortadaController.stream;

  @override
  Stream<String> get onHiloEliminado => _portadaDeletedController.stream;

  @override
  void connect() {
    //_init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  void _init() {
    // Simulate new portadas every 5-15 seconds
    Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        final id = uuid.v4();
        portadas.add(id);
        _newPortadaController.add(
          Portada(
            id: id,
            titulo: "Pepito",
            categoria: "NSFW",
            esOp: random.nextBool(),
            features: const [PortadaFeatures.sticky],
            ultimoBump: DateTime.now(),
            imagen: Spoileable(
              random.nextBool(),
              const Imagen(
                provider: NetworkProvider(
                  path:
                      "https://upload.wikimedia.org/wikipedia/en/4/4c/GokumangaToriyama.png?20210917000338",
                ),
              ),
            ),
          ),
        );
      },
    );

    Timer.periodic(
      const Duration(seconds: 30),
      (_) => _portadaDeletedController
          .add(portadas.elementAt(random.nextInt(portadas.length))),
    );
  }
}
