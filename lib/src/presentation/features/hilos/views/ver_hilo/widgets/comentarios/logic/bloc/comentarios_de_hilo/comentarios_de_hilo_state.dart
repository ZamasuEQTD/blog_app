part of 'comentarios_de_hilo_bloc.dart';

class ComentariosDeHiloState extends Equatable {
  final int pagina;
  final List<Comentario> comentarios;
  final ComentariosDeHiloStatus status;
  const ComentariosDeHiloState({
    this.pagina = 1,
    this.comentarios = const [],
    this.status = ComentariosDeHiloStatus.initial
  });
  
  ComentariosDeHiloState copyWith({
    int? pagina,
    List<Comentario>? comentarios,
    ComentariosDeHiloStatus? status
  }){
    return ComentariosDeHiloState(
      pagina: pagina?? this.pagina,
      status: status?? this.status,
      comentarios: comentarios?? this.comentarios
    );
  }

  @override
  List<Object> get props => [
    pagina,
    comentarios,
    status
  ];
}

enum ComentariosDeHiloStatus {
  initial,
  cargando,
  cargados,
  failure
}