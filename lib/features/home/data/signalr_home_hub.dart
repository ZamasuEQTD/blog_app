import 'dart:async';

import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:blog_app/features/home/domain/hub/ihome_portadas_hub.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalrHomeHub extends IPortadasHub {
  late final HubConnection hub;

  final HubConnectionBuilder connection = HubConnectionBuilder();

  final onHiloEliminadoController = StreamController<String>.broadcast();

  final onHiloPosteadoController = StreamController<PortadaHilo>.broadcast();
  @override
  void connect() {
    hub = connection.build();

    hub.start();

    hub.on("HiloEliminado", (data) {
      onHiloEliminadoController.add(data![0] as String);
    });

    hub.on("HiloPosteado", (data) {
      onHiloPosteadoController.add(
        PortadaHilo.fromJson(data![0] as Map<String, dynamic>),
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
  Stream<PortadaHilo> get onHiloPosteado => onHiloPosteadoController.stream;
}
