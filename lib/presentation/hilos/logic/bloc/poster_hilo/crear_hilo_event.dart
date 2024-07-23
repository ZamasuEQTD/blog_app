part of 'crear_hilo_bloc.dart';

sealed class CrearHiloEvent extends Equatable {
  const CrearHiloEvent();

  @override
  List<Object> get props => [];
}


class CambiarTitulo extends CrearHiloEvent {
  final String titulo;

  const CambiarTitulo({required this.titulo});
}

class CambiarDescripcion extends CrearHiloEvent {
  final String descripcion;

  const CambiarDescripcion({required this.descripcion});
}

class CambiarBanderas extends CrearHiloEvent {
  final bool? dados;
  final bool? tagUnico;

  const CambiarBanderas({
    this.dados, 
    this.tagUnico
  });
}

class AgregarMedia extends CrearHiloEvent {
  final Media media;

  const AgregarMedia({required this.media});
}

class SwitchSpoiler extends CrearHiloEvent {}

class EliminarMedia extends CrearHiloEvent {}

class PostearHilo extends CrearHiloEvent {}