part of 'portadas_home_bloc.dart';

class PortadasHomeState extends Equatable {
  final PortadasHomeFiltrosState filtros;
  final PortadasHomeStatus status;
  final List<HomePortadaDeHilo> portadas;
  final Failure? failure;
  const PortadasHomeState({
    this.portadas = const [],
    this.status = PortadasHomeStatus.initial,
    this.filtros = const PortadasHomeFiltrosState(),
    this.failure
  });
  
  PortadasHomeState copyWith({
    PortadasHomeFiltrosState? filtros,
    PortadasHomeStatus? status,
    List<HomePortadaDeHilo>? portadas,
    Failure? failure
  }) => PortadasHomeState(
    filtros: filtros?? this.filtros,
    failure: failure?? this.failure,
    portadas: portadas?? this.portadas,
    status:  status?? this.status
  );

  @override
  List<Object?> get props => [
    status,
    filtros,
    portadas,
    failure
  ];
}

enum PortadasHomeStatus {
  initial,
  cargando,
  failure,
}

class PortadasHomeFiltrosState extends Equatable {
  final Subcategoria? subcategoria;
  final String? titulo;
  final DateTime? ultimoBump;
  const PortadasHomeFiltrosState({
    this.subcategoria, 
    this.titulo,
    this.ultimoBump
  });

  PortadasHomeFiltrosState copyWith({
   Subcategoria? subcategoria,
   String? titulo,
   DateTime? ultimoBump,
  }){
    return PortadasHomeFiltrosState(
      subcategoria: subcategoria?? this.subcategoria, 
      titulo: titulo?? this.titulo,
      ultimoBump: ultimoBump
    );
  }
  
  @override
  List<Object?> get props =>  [
    subcategoria,
    titulo,
    ultimoBump
  ];
}