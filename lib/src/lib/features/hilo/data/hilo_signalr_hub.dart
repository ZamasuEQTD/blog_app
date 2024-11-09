import 'dart:async';

import 'package:blog_app/src/lib/features/comentarios/domain/models/comentario.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/src/lib/features/hilo/domain/hub/ihilo_hub.dart';
import 'package:blog_app/src/lib/features/hilo/domain/models/types.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

import '../../home/data/signalr_home_hub.dart';

class HiloSignalrHub extends IHiloHub {
  late final HubConnection hub;

  final HubConnectionBuilder connection = HubConnectionBuilder();

  final eliminadoController = StreamController<ComentarioId>.broadcast();

  final comentadoController = StreamController<Comentario>.broadcast();

  @override
  void connect(HiloId id) {
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
