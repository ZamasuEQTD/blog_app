// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'historial_de_hilos_bloc.dart';

class HistorialDeHilosState extends Equatable {
  final HistorialDeHilosStatus status;
  final List<PortadaEntity> portadas;
  const HistorialDeHilosState({
    this.portadas = const [],
    this.status = HistorialDeHilosStatus.initial,
  });

  @override
  List<Object> get props => [
        status,
        portadas,
      ];

  HistorialDeHilosState copyWith({
    HistorialDeHilosStatus? status,
    List<PortadaEntity>? portadas,
  }) {
    return HistorialDeHilosState(
      status: status ?? this.status,
      portadas: portadas ?? this.portadas,
    );
  }
}

enum HistorialDeHilosStatus { initial, cargando, cargados }
