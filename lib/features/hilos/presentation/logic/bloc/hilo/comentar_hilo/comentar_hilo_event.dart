part of 'comentar_hilo_bloc.dart';

sealed class ComentarHiloEvent extends Equatable {
  const ComentarHiloEvent();

  @override
  List<Object> get props => [];
}

class CambiarComentario extends ComentarHiloEvent {
  final String comentario;

  const CambiarComentario({required this.comentario});
}

class EnviarComentario extends ComentarHiloEvent {}

class SwitchDeMediaSpoiler extends ComentarHiloEvent {}

class AggregarTaggueo extends ComentarHiloEvent {
  final String tag;

  const AggregarTaggueo({required this.tag});
}
