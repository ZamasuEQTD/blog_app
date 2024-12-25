import 'package:blog_app/features/notificaciones/domain/models/notificacion.dart';

abstract class INotificacionesHub {
  Stream<Notificacion> get onUsuarioNotificado;

  void connect();

  void dispose();
}
