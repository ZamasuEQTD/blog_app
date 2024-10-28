part of 'hilo_bloc.dart';

sealed class HiloEvent extends Equatable {
  const HiloEvent();

  @override
  List<Object> get props => [];
}

class EliminarComentario extends HiloEvent {
  final ComentarioId id;

  const EliminarComentario({required this.id});
}

class AgregarComentario extends HiloEvent {
  final Comentario comentario;

  const AgregarComentario({required this.comentario});
}

class CargarHilo extends HiloEvent {}

class RecargarHilo extends HiloEvent {}

class EliminarHilo extends HiloEvent {}

class CargarComentarios extends HiloEvent {}
