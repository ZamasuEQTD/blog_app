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
