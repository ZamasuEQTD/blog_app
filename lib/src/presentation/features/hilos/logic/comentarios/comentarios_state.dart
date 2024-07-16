part of 'comentarios_bloc.dart';

class ComentariosState extends Equatable {
  final List<ComentarioHilo> comentarios;

  final ComentariosStatus status;

  const ComentariosState({
    this.comentarios = const [],
    this.status = ComentariosStatus.initial
  });

  ComentariosState copyWith({
    List<ComentarioHilo>? comentarios,
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

abstract class ComentarioItem {
  const ComentarioItem(); 
}

class ComentarioHilo extends ComentarioItem {
  final ComentarioId id;
  final String texto;
  final DatosDeComentario datos;
  final DateTime createdAt;
  final Spoileable<Media>? media;

  const ComentarioHilo({required this.id, required this.texto, required this.datos, required this.createdAt, required this.media});
}

class CargandoComentarioHilo  extends ComentarioItem {}