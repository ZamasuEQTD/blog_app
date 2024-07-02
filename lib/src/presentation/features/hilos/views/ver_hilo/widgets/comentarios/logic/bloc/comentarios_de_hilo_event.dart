part of 'comentarios_de_hilo_bloc.dart';

sealed class ComentariosDeHiloEvent extends Equatable {
  const ComentariosDeHiloEvent();

  @override
  List<Object> get props => [];
}

class EliminarComentario extends ComentariosDeHiloEvent {
  final ComentarioId id;

  const EliminarComentario({required this.id});

  @override
  List<Object> get props => [id];
}

class AgregarComentario extends ComentariosDeHiloEvent {
  final Comentario comentario;

  const AgregarComentario({required this.comentario});

  @override
  List<Object> get props => [comentario];
}

class CargarComentarios extends ComentariosDeHiloEvent {

  const CargarComentarios( );

  @override
  List<Object> get props => [];
}

