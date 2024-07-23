part of 'comentar_hilo_bloc.dart';

sealed class ComentarHiloEvent extends Equatable {
  const ComentarHiloEvent();

  @override
  List<Object> get props => [];
}

class EnviarComentario extends ComentarHiloEvent {}

class SwitchDeMediaSpoiler extends ComentarHiloEvent {}

class AgregarMedia extends ComentarHiloEvent {
  final Media media;

  const AgregarMedia({required this.media});
}