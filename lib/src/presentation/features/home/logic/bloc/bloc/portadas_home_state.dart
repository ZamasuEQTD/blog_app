part of 'portadas_home_bloc.dart';

class PortadasHomeState extends Equatable {
  final PortadasHomeStatus status;
  final List<PortadaDeHilo> portadas;
  final Failure? failure;
  const PortadasHomeState({
    this.status = PortadasHomeStatus.initial,
    this.portadas = const [],
    this.failure
  });
  
  @override
  List<Object> get props => [];

  PortadasHomeState copyWith({
    PortadasHomeStatus? status,
    List<PortadaDeHilo>? portadas,
    Failure? failure,
  }) {
    return PortadasHomeState(
      status: status?? this.status,
      portadas: portadas??this.portadas,
      failure: failure?? this.failure
    );
  }
}

enum PortadasHomeStatus {
  initial,
  cargando,
  cargados,
  fallido
}