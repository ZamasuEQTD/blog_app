part of 'comentar_hilo_bloc.dart';

sealed class ComentarHiloEvent extends Equatable {
  const ComentarHiloEvent();

  @override
  List<Object> get props => [];
}


class CambiarTexto extends ComentarHiloEvent {
  final String texto;

  const CambiarTexto({required this.texto});
  @override
  List<Object> get props => [texto];
}

class EnviarComentario extends ComentarHiloEvent {}