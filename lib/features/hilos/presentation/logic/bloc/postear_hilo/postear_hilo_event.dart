part of 'postear_hilo_bloc.dart';

sealed class PostearHiloEvent extends Equatable {
  const PostearHiloEvent();

  @override
  List<Object> get props => [];
}

class CambiarTitulo extends PostearHiloEvent {
  final String titulo;

  const CambiarTitulo({required this.titulo});
}

class CambiarDescripcion extends PostearHiloEvent {
  final String descripcion;

  const CambiarDescripcion({required this.descripcion});
}

class CambiarBanderas extends PostearHiloEvent {
  final bool? dados;
  final bool? tagUnico;

  const CambiarBanderas({this.dados, this.tagUnico});
}

class AgregarMedia extends PostearHiloEvent {
  final Media media;

  const AgregarMedia({required this.media});
}

class CambiarSubcategoria extends PostearHiloEvent {
  final SubcategoriaEntity subcategoria;

  const CambiarSubcategoria({required this.subcategoria});
}

class SwitchSpoiler extends PostearHiloEvent {}

class EliminarMedia extends PostearHiloEvent {}

class PostearHilo extends PostearHiloEvent {}
