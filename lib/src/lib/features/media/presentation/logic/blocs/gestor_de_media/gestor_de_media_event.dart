part of 'gestor_de_media_bloc.dart';

sealed class GestorDeMediaEvent extends Equatable {
  const GestorDeMediaEvent();

  @override
  List<Object> get props => [];
}

class AgregarMedia extends GestorDeMediaEvent {
  final Media media;

  const AgregarMedia({required this.media});
}

class EliminarMedia extends GestorDeMediaEvent {
  final int? index;

  const EliminarMedia({this.index});
}
