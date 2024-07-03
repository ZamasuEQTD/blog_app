part of 'comentarios_de_hilo_bloc.dart';

sealed class ComentariosDeHiloEvent extends Equatable {
  const ComentariosDeHiloEvent();

  @override
  List<Object> get props => [];
}


class CargarComentarios  extends ComentariosDeHiloEvent {
  const CargarComentarios();
}