part of 'comentarios_de_hilo_bloc.dart';

class ComentariosDeHiloState extends Equatable {
  final List<Comentario> comentarios;
  final Failure? error;
  final ComentariosDeHiloStatus status;
  final int pagina;
  const ComentariosDeHiloState({
      this.status = ComentariosDeHiloStatus.initial,
      this.comentarios = const [],
      this.pagina = 1,
      this.error
  });
  
  @override
  List<Object?> get props => [comentarios,error, status];

  ComentariosDeHiloState copyWith({
    List<Comentario>? comentarios,
    int? pagina,
    Failure? error,
    ComentariosDeHiloStatus? status
  }) {
    return ComentariosDeHiloState(
      comentarios: comentarios?? this.comentarios,
      pagina: pagina?? this.pagina,
      error: error?? this.error,
      status: status?? this.status
    );
  }
}


enum ComentariosDeHiloStatus {
  initial,
  cargando,
  fallido,
}
