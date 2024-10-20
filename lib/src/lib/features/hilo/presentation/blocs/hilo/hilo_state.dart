// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'hilo_bloc.dart';

class HiloState extends Equatable {
  final Hilo? hilo;
  final HiloStatus status;
  final ComentariosStatus comentariosStatus;

  const HiloState({
    this.hilo,
    this.status = HiloStatus.initial,
    this.comentariosStatus = ComentariosStatus.cargado,
  });

  @override
  List<Object?> get props => [hilo, status, comentariosStatus];

  HiloState copyWith({
    Hilo? hilo,
    HiloStatus? status,
    ComentariosStatus? comentariosStatus,
  }) {
    return HiloState(
      hilo: hilo ?? this.hilo,
      status: status ?? this.status,
      comentariosStatus: comentariosStatus ?? this.comentariosStatus,
    );
  }
}

enum HiloStatus { initial, cargando, cargado }

enum ComentariosStatus {
  initial,
  cargado,
  cargados,
  failure,
}
