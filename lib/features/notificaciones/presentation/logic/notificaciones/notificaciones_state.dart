// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notificaciones_bloc.dart';

class NotificacionesState extends Equatable {
  final NotificacionesStatus status;
  final List<Notificacion> notificaciones;

  const NotificacionesState({
    this.status = NotificacionesStatus.inicial,
    this.notificaciones = const [],
  });

  @override
  List<Object> get props => [];

  NotificacionesState copyWith({
    NotificacionesStatus? status,
    List<Notificacion>? notificaciones,
  }) {
    return NotificacionesState(
      status: status ?? this.status,
      notificaciones: notificaciones ?? this.notificaciones,
    );
  }
}

enum NotificacionesStatus { inicial, cargando, cargadas, fallido }
