part of 'historial_de_comentarios_bloc.dart';

sealed class HistorialDeComentariosEvent extends Equatable {
  const HistorialDeComentariosEvent();

  @override
  List<Object> get props => [];
}

class CargarSiguientePagina extends HistorialDeComentariosEvent {}
