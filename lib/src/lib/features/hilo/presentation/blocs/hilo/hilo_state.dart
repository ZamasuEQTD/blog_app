// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'hilo_bloc.dart';

class HiloState extends Equatable {
  final Hilo? hilo;
  final HiloStatus status;
  final List<Comentario> comentarios;
  final DateTime? ultimoComentario;
  final ComentariosState comentariosState;
  const HiloState({
    this.hilo,
    this.status = HiloStatus.initial,
    this.comentarios = const [],
    this.ultimoComentario,
    this.comentariosState = const ComentariosState.initial(),
  });

  @override
  List<Object?> get props => [
        hilo,
        status,
        comentarios,
        ultimoComentario,
        comentariosState,
      ];

  HiloState copyWith({
    Hilo? hilo,
    HiloStatus? status,
    List<Comentario>? comentarios,
    DateTime? ultimoComentario,
    ComentariosState? comentariosState,
  }) {
    return HiloState(
      hilo: hilo ?? this.hilo,
      status: status ?? this.status,
      comentarios: comentarios ?? this.comentarios,
      ultimoComentario: ultimoComentario ?? this.ultimoComentario,
      comentariosState: comentariosState ?? this.comentariosState,
    );
  }
}

enum HiloStatus { initial, cargando, cargado }

abstract class ComentariosState extends Equatable {
  const ComentariosState();

  const factory ComentariosState.initial() = InitialComentariosState;
  const factory ComentariosState.cargando() = CargandoComentariosState;
  const factory ComentariosState.cargados({
    required List<Comentario> comentarios,
  }) = ComentariosCargadosState;

  @override
  List<Object?> get props => [];
}

class InitialComentariosState extends ComentariosState {
  const InitialComentariosState();
}

class CargandoComentariosState extends ComentariosState {
  const CargandoComentariosState();
}

class ComentariosCargadosState extends ComentariosState {
  final List<Comentario> comentarios;
  const ComentariosCargadosState({
    required this.comentarios,
  });
}
