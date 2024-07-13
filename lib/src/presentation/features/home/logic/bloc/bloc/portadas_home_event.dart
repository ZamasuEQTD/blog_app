part of 'portadas_home_bloc.dart';

sealed class PortadasHomeEvent extends Equatable {
  const PortadasHomeEvent();

  @override
  List<Object> get props => [];
}

class CargarPortadasHome extends PortadasHomeEvent {}

class CambiarFiltrosDePortadas extends PortadasHomeEvent{
  final Subcategoria? subcategoria;
  final String? titulo;

  const CambiarFiltrosDePortadas({
    required this.subcategoria, required this.titulo
  });
}