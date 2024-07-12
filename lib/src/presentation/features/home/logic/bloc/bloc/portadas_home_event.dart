part of 'portadas_home_bloc.dart';

sealed class PortadasHomeEvent extends Equatable {
  const PortadasHomeEvent();

  @override
  List<Object> get props => [];
}

class CargarPortadas extends PortadasHomeEvent {
  const CargarPortadas();
}

class ReiniciarPortadas extends PortadasHomeEvent {}

class AgregarPortadaAlInicio extends PortadasHomeEvent {
  final PortadaDeHilo portada;

  const AgregarPortadaAlInicio({
    required this.portada
  });
}

class EliminarPortada extends PortadasHomeEvent {
  final HiloId id;

  const EliminarPortada({required this.id});
}

class CambiarFiltrosHomePortadas extends PortadasHomeEvent{
  final DateTime? ultimoBump;
  final String? titulo;
  final SubcategoriaId? subcategoriaId;

  const CambiarFiltrosHomePortadas({ this.ultimoBump,  this.titulo,  this.subcategoriaId});
}