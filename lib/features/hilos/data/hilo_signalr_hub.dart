import 'dart:async';

import 'package:blog_app/features/comentarios/domain/models/comentario.dart';
import 'package:blog_app/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/features/hilos/domain/ihilo_hub.dart';
import 'package:blog_app/modules/routing.dart';

import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class HiloSignalrHub extends IHiloHub {
  late final HubConnection hub;

  final HubConnectionBuilder connection = HubConnectionBuilder();

  final eliminadoController = StreamController<ComentarioId>.broadcast();

  final comentadoController = StreamController<Comentario>.broadcast();

  @override
  void connect(String id) {
    hub = connection.withUrl("${HubRoutes.hilo}/$id").build();

    hub.start();
  }

  @override
  void dispose() {
    hub.stop();
    eliminadoController.close();
    comentadoController.close();
  }

  @override
  Stream<ComentarioId> get onComentarioEliminado => eliminadoController.stream;

  @override
  Stream<Comentario> get onComentarioPosteado => comentadoController.stream;
}
