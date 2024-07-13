part of 'portadas_home_bloc.dart';

class PortadasHomeState extends Equatable {
  final PortadasHomeFiltros filtros;
  final PortadasHomeStatus status;
  final List<PortadaHome> portadas;
  final Failure? failure;
  const PortadasHomeState({
    this.portadas = const [],
    this.status = PortadasHomeStatus.initial,
    this.filtros = const PortadasHomeFiltros(),
    this.failure
  });
  
  PortadasHomeState copyWith({
    PortadasHomeFiltros? filtros,
    PortadasHomeStatus? status,
    List<PortadaHome>? portadas,
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

class PortadasHomeFiltros extends Equatable {
  final Subcategoria? subcategoria;
  final String? titulo;
  final DateTime? ultimoBump;
  const PortadasHomeFiltros({
    this.subcategoria, 
    this.titulo,
    this.ultimoBump
  });

  PortadasHomeFiltros copyWith({
   Subcategoria? subcategoria,
   String? titulo,
   DateTime? ultimoBump,
  }){
    return PortadasHomeFiltros(
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