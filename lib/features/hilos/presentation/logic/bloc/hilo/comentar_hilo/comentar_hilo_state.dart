part of 'comentar_hilo_bloc.dart';

class ComentarHiloState extends Equatable {
  final String texto;
  final Spoileable<Media>? media;
  final ComentarHiloStatus status;
  final String? taggueo;
  const ComentarHiloState({
    this.status = ComentarHiloStatus.initial,
    this.texto = "",
    this.media,
    this.taggueo,
  });

  ComentarHiloState copyWith(
          {String? texto,
          Nullable<Spoileable<Media>>? media,
          ComentarHiloStatus? status,
          String? taggueo}) =>
      ComentarHiloState(
        texto: texto ?? this.texto,
        media: media != null ? media.value : this.media,
        status: status ?? this.status,
        taggueo: taggueo,
      );

  @override
  List<Object?> get props => [texto, media, status];
}

enum ComentarHiloStatus { initial, enviando, enviado, failure }
