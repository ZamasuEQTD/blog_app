import 'dart:async';
import 'dart:developer';

import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:blog_app/features/home/domain/hub/ihome_hub.dart';
import 'package:blog_app/modules/config/api_config.dart';
import 'package:signalr_netcore/signalr_client.dart';

class SignalrHomeHub extends IHomeHub {
  late final HubConnection hub;

  final HubConnectionBuilder connection =
      HubConnectionBuilder().withUrl("${ApiConfig.baseUrl}/home-hub");

  final onHiloEliminadoController = StreamController<String>.broadcast();

  final onHiloPosteadoController = StreamController<PortadaHilo>.broadcast();
  @override
  void connect() {
    hub = connection.build();

    hub.start()!.then(
      (value) {
        log("Hub conectado");

        hub.on("OnHiloEliminado", (data) {
          onHiloEliminadoController.add(data![0] as String);
        });

        hub.on("OnHiloPosteado", (data) {
          try {
            Map<String, dynamic> json = data![0] as Map<String, dynamic>;
            onHiloPosteadoController.add(
              PortadaHilo.fromJson({
                ...json,
              }),
            );
          } catch (e) {
            log("Error al procesar hilo posteado: $e");
          }
        });
      },
      onError: (error, stackTrace) {
        log("Hub no conectado: $error");
      },
    );
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
