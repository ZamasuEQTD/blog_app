part of 'comentar_hilo_bloc.dart';

class ComentarHiloState extends Equatable {
  final String texto;
  final Spoileable<Media>? media;
  final String? ultimoTaggueo;
  final ComentarHiloStatus status;
  const ComentarHiloState({
    this.texto = "",
    this.media,
    this.ultimoTaggueo,
    this.status = ComentarHiloStatus.initial,
  });

  ComentarHiloState copyWith(
          {String? texto,
          Spoileable<Media>? media,
          String? ultimoTaggueo,
          ComentarHiloStatus? status}) =>
      ComentarHiloState(
          texto: texto ?? this.texto,
          media: media ?? this.media,
          ultimoTaggueo: ultimoTaggueo ?? this.ultimoTaggueo,
          status: status ?? this.status);

  @override
  List<Object?> get props => [texto, media, ultimoTaggueo, status];
}

class TagState extends Equatable {
  final String? ultimoTaggueo;

  const TagState({this.ultimoTaggueo});

  @override
  List<Object?> get props => [ultimoTaggueo];
}

enum ComentarHiloStatus { initial, enviando, enviado, failure }
