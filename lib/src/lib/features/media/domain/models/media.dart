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

class TipoDeMedia extends Equatable {
  final String value;

  const TipoDeMedia(this.value);

  @override
  List<Object?> get props => [value];

  static const video = TipoDeMedia("video");
  static const imagen = TipoDeMedia("imagen");
  static const youtube = TipoDeMedia("youtube");
}
