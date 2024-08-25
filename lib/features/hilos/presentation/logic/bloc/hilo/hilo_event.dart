part of 'hilo_bloc.dart';

sealed class HiloEvent extends Equatable {
  const HiloEvent();

  @override
  List<Object> get props => [];
}

class CargarHilo extends HiloEvent {}

class RecargarHilo extends HiloEvent {}

class EliminarHilo extends HiloEvent {}

class AgregarComentario extends HiloEvent {
  final ComentarioListEntry comentario;

  const AgregarComentario(this.comentario);
}

class EliminarComentario extends HiloEvent {
  final ComentarioId id;

  const EliminarComentario(this.id);
}

class CargarComentarios extends HiloEvent {}
