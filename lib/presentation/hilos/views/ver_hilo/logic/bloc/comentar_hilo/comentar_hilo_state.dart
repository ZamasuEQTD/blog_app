part of 'comentar_hilo_bloc.dart';

class ComentarHiloState extends Equatable {
  final String texto;
  final Spoileable<Media>? media;
  final ComentarHiloStatus status;
  const ComentarHiloState({
    this.texto = "",
    this.media,
    this.status = ComentarHiloStatus.initial,
  });
  
  ComentarHiloState copyWith({
    String? texto,
    Spoileable<Media>? media,
    String? ultimoTaggueo,
    ComentarHiloStatus? status
  }) => ComentarHiloState(
    texto: texto?? this.texto,
    media: media?? this.media,
    status: status??this.status
  );

  @override
  List<Object?> get props => [
    texto,
    media,
    status
  ];
}
 

enum ComentarHiloStatus {
  initial,
  enviando,
  enviado,
  failure
}