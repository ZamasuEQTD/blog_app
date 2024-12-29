import 'dart:async';

import 'package:blog_app/features/notificaciones/domain/inotificaciones_hub.dart';
import 'package:blog_app/features/notificaciones/domain/models/notificacion.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class SignalrNotificacionesHub extends INotificacionesHub {
  @override
  Stream<Notificacion> get onUsuarioNotificado => throw UnimplementedError();

  final _controller = StreamController<Notificacion>.broadcast();

  final HubConnection connection = HubConnectionBuilder().build();

  @override
  void connect() async {
    await connection.start();

    connection.on(
      "OnUsuarioNotificado",
      (arguments) => _notificar(arguments![0] as Map<String, dynamic>),
    );
  }

  void _notificar(Map<String, dynamic> json) {
    _controller.add(Notificacion.fromJson(json));
  }

  @override
  void dispose() {
    connection.stop();
  }
}
