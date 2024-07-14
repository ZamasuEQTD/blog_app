part of 'comentar_hilo_bloc.dart';

 class ComentarHiloState extends Equatable {
  final String texto;
  final Spoileable<Media>? media;
  final ComentarHiloStatus status;

  const ComentarHiloState({
    this.texto = "",
    this.status = ComentarHiloStatus.initial,
    this.media
  });

  ComentarHiloState copyWith({
    String? texto,
    Spoileable<Media>?media,
    ComentarHiloStatus?status
  }) {
    return ComentarHiloState(
      texto: texto?? this.texto,
      media: media?? this.media,
      status: status?? this.status
    );
  }


  @override
  List<Object?> get props => [
    texto,
    media
  ];
}


enum ComentarHiloStatus {
  initial,
  enviando,
  enviado,
  failure
}


class TagsUtils {
  TagsUtils._();

  static HashSet<String> getTags() {
    return HashSet();
  }
}