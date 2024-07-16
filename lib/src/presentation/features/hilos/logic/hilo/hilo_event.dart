part of 'hilo_bloc.dart';

sealed class HiloEvent extends Equatable {
  const HiloEvent();

  @override
  List<Object> get props => [];
}

class CambiarComentario extends HiloEvent{
  final String comentario;

  const CambiarComentario({required this.comentario});
  
  @override
  List<Object> get props => [comentario];
}

class CargarHilo extends HiloEvent {}
class CargarComentarios extends HiloEvent {}
class RecargarHilo extends HiloEvent {}
class EnviarComentario extends HiloEvent {}