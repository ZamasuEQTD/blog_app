part of 'comentarios_bloc.dart';

sealed class ComentariosEvent extends Equatable {
  const ComentariosEvent();

  @override
  List<Object> get props => [];
}

class AgregarComentario extends ComentariosEvent {
  final Comentario comentario;

  const AgregarComentario(this.comentario);
}

class EliminarComentario extends ComentariosEvent {
  final ComentarioId id;

  const EliminarComentario(this.id);
}

class CargarComentarios extends ComentariosEvent {}