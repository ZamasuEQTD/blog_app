// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Media extends Equatable {
  final MediaProvider provider;
  final TipoDeMedia tipo;
  const Media({
    required this.provider,
    required this.tipo,
  });

  @override
  List<Object?> get props => [provider];
}

class Video extends Media {
  final String? previsualizacion;
  const Video({
    this.previsualizacion,
    required super.provider,
  }) : super(tipo: TipoDeMedia.video);
}

class Imagen extends Media {
  const Imagen({required super.provider}) : super(tipo: TipoDeMedia.imagen);
}

abstract class MediaProvider extends Equatable {
  final String path;
  const MediaProvider({
    required this.path,
  });

  @override
  List<Object?> get props => [path];
}

class NetworkProvider extends MediaProvider {
  const NetworkProvider({required super.path});
}

class FileProvider extends MediaProvider {
  const FileProvider({required super.path});
}

class Youtube extends Media {
  const Youtube({
    required NetworkProvider super.provider,
  }) : super(tipo: TipoDeMedia.youtube);

  factory Youtube.fromUrl(String url) {
    return Youtube(
      provider: NetworkProvider(path: url),
    );
  }
}

class YoutubeService {
  static RegExp youtubeIdRegex =
      RegExp(r'(youtu.*be.*)\/(watch\?v=|embed\/|v|shorts|)(.*?((?=[&#?])|$))');

  static RegExp youtubeLinkRegex = RegExp(
    r'^https?:\/\/(www\.)?youtu(\.be\/|be\.com\/)(watch\?v=|embed\/|v\/|shorts\/)([A-Za-z0-9-_]{11})((?=[&#?])|$)',
  );

  static String miniaturaFromUrl(String url) =>
      miniaturaFromId(getVideoId(url));

  static String getVideoId(String url) {
    var match = youtubeIdRegex.firstMatch(url);

    if (match == null) throw Exception("Link invalido");

    return match.group(3)!;
  }

  static String miniaturaFromId(String id) =>
      'https://img.youtube.com/vi/$id/1.jpg';
}

class TipoDeMedia extends Equatable {
  final String value;

  const TipoDeMedia(this.value);

  @override
  List<Object?> get props => [value];

  static const video = TipoDeMedia("video");
  static const imagen = TipoDeMedia("imagen");
  static const youtube = TipoDeMedia("youtube");
}
