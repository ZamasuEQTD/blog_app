part of 'home_portadas_bloc.dart';

sealed class HomePortadasEvent extends Equatable {
  const HomePortadasEvent();

  @override
  List<Object> get props => [];
}

class CargarPortadasHome extends HomePortadasEvent {}

class CambiarFiltrosDePortadas extends HomePortadasEvent {
  final Subcategoria? subcategoria;
  final String? titulo;

  const CambiarFiltrosDePortadas({this.subcategoria, this.titulo});
}

class RecargarHomePortadas extends HomePortadasEvent {}

class AgregarPortada extends HomePortadasEvent {
  final HomePortadaEntity portada;

  const AgregarPortada({required this.portada});
}

class EliminarPortada extends HomePortadasEvent {
  final HiloId id;

  const EliminarPortada({required this.id});
}
