part of 'hilo_bloc.dart';

class HiloState extends Equatable {
  final Hilo? hilo;
  final HiloStatus status;
  
  
  const HiloState({
    this.hilo,
    this.status = HiloStatus.initial
  });
  
  HiloState copyWith({
    Hilo? hilo,
    HiloStatus? status,
  }){ 
    return HiloState(
      hilo: hilo?? this.hilo,
      status: status?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    hilo,
    status,
  ];
}

enum HiloStatus {
  initial,
  cargando,
  cargado
}



class ComentarioDeUsuarioState {
  final String comentario;
  final Spoileable<Media>? media;
  final ComentarioDeUsuarioStatus status;
  const ComentarioDeUsuarioState({
    this.comentario ="",
    this.media,
    this.status = ComentarioDeUsuarioStatus.initial
  });
}

enum ComentarioDeUsuarioStatus {
  initial,
  enviando,
  enviado,
  failure
}





















