import '../../../hilo/domain/models/types.dart';

class Notificacion {
  final NotificacionId id;
  final String titulo;
  final HiloId hiloId;

  const Notificacion({
    required this.id,
    required this.titulo,
    required this.hiloId,
  });
}

typedef NotificacionId = String;
