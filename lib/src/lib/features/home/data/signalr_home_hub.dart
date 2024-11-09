import 'dart:async';

import 'package:blog_app/src/lib/features/home/domain/hub/ihome_portadas_hub.dart';
import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:signalr_netcore/signalr_client.dart';

class HubRoutes {
  static const String home = "Home";
  static const String hilo = "hilo/";
}

class SignalrHomeHub extends IHomePortadasHub {
  late final HubConnection hub;

  final HubConnectionBuilder connection = HubConnectionBuilder();

  final onHiloEliminadoController = StreamController<String>.broadcast();

  final onHiloPosteadoController = StreamController<HomePortada>.broadcast();
  @override
  void connect() {
    hub = connection.build();

    hub.start();

    hub.on("HiloEliminado", (data) {
      onHiloEliminadoController.add(data![0] as String);
    });

    hub.on("HiloPosteado", (data) {
      onHiloPosteadoController.add(
        HomePortada.fromJson(data![0] as Map<String, dynamic>),
      );
    });
  }

  @override
  void dispose() {
    hub.stop();

    onHiloEliminadoController.close();
    onHiloPosteadoController.close();
  }

  @override
  Stream<String> get onHiloEliminado => onHiloEliminadoController.stream;

  @override
  Stream<HomePortada> get onHiloPosteado => onHiloPosteadoController.stream;
}
