import 'dart:async';
import 'dart:developer';

import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:blog_app/features/home/domain/hub/ihome_portadas_hub.dart';
import 'package:blog_app/modules/config/api_config.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalrHomeHub extends IPortadasHub {
  late final HubConnection hub;

  final HubConnectionBuilder connection =
      HubConnectionBuilder().withUrl("${ApiConfig.baseUrl}/hilos-hub");

  final onHiloEliminadoController = StreamController<String>.broadcast();

  final onHiloPosteadoController = StreamController<PortadaHilo>.broadcast();
  @override
  void connect() {
    hub = connection.build();

    hub.start()!.then(
      (value) {
        log("Hub conectado");
      },
      onError: (error, stackTrace) {
        log("Hub no conectado: $error");
      },
    );

    hub.on("OnHiloEliminado", (data) {
      onHiloEliminadoController.add(data![0] as String);
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      onHiloEliminadoController.add("hghjjja");
    });

    hub.on("OnHiloPosteado", (data) {
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
