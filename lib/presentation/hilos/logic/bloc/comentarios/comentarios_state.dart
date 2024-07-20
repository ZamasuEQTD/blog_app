part of 'comentarios_bloc.dart';

class ComentariosState extends Equatable {
  final List<Comentario> comentarios;

  final ComentariosStatus status;

  const ComentariosState({
    this.comentarios = const [],
    this.status = ComentariosStatus.initial
  });

  ComentariosState copyWith({
    List<Comentario>? comentarios,
    ComentariosStatus? status
  }){
    return ComentariosState(
      comentarios: comentarios?? this.comentarios,
      status: status?? this.status
    );
  }


  @override
  List<Object?> get props => [
    comentarios,
    status
  ];
}

enum ComentariosStatus {
  initial,
  cargado,
  cargados,
  failure,
}
typedef ComentarioId = String;