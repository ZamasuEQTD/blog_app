part of 'comentar_hilo_bloc.dart';

class ComentarHiloState extends Equatable {
  final String texto;
  final Spoileable<Media>? media;
  final ComentarHiloStatus status;
  final TagState tagState;
  const ComentarHiloState({
    this.texto = "",
    this.media,
    this.tagState = const TagState(),
    this.status = ComentarHiloStatus.initial,
  });
  
  ComentarHiloState copyWith({
    String? texto,
    Spoileable<Media>? media,
    String? ultimoTaggueo,
    TagState? tagState,
    ComentarHiloStatus? status
  }) => ComentarHiloState(
    texto: texto?? this.texto,
    media: media?? this.media,
    tagState: tagState?? this.tagState,
    status: status??this.status
  );

  @override
  List<Object?> get props => [
    texto,
    media,
    tagState,
    status
  ];
}

class TagState extends Equatable {
  final String? ultimoTaggueo;
  final TagStatus? status;

  const TagState({
    this.status = TagStatus.initial,
    this.ultimoTaggueo
  });
  
  @override
  List<Object?> get props => [
    ultimoTaggueo,
    status
  ];
}

enum TagStatus {
  initial,
  taggueado,
}

enum ComentarHiloStatus {
  initial,
  enviando,
  enviado,
  failure
}