part of 'notificaciones_bloc.dart';

sealed class NotificacionesEvent extends Equatable {
  const NotificacionesEvent();

  @override
  List<Object> get props => [];
}

class CargarNotificaciones extends NotificacionesEvent {}

class LeerNotificacion extends NotificacionesEvent {
  final NotificacionId id;

  const LeerNotificacion(this.id);
}

class LeerTodasLasNotificaciones extends NotificacionesEvent {
  const LeerTodasLasNotificaciones();
}
