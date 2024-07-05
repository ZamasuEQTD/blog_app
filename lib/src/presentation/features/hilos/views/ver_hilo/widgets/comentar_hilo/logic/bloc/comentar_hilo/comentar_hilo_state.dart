part of 'comentar_hilo_bloc.dart';

class ComentarHiloState extends Equatable {
  final String comentario;
  final List<String> ids;
  final ComentarHiloStatus status;

  const ComentarHiloState({
    this.comentario = "",
    this.ids = const [],
    this.status = ComentarHiloStatus.initial
  });
  
  @override
  List<Object> get props => [
    comentario,
    ids,
    status
  ];

  ComentarHiloState copyWith({
    String? comentario,
    List<String>? ids,
    ComentarHiloStatus? status
  }){
    return ComentarHiloState(
      comentario: comentario?? this.comentario,
      ids: ids?? this.ids,
      status: status?? this.status
    );
  }
}

enum ComentarHiloStatus {
  initial,
  cargando,
  enviado,
  fallido
}