part of 'comentar_hilo_bloc.dart';

sealed class ComentarHiloEvent extends Equatable {
  const ComentarHiloEvent();

  @override
  List<Object> get props => [];
}

class EnviarComentario extends ComentarHiloEvent {}