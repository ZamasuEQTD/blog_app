import 'package:equatable/equatable.dart';

abstract class Media extends Equatable {
  final MediaProvider provider;
  final TipoDeMedia tipo;
  const Media({
    required this.provider,
    required this.tipo,
  });

  static Media fromJson(Map<String, dynamic> json) {
    switch (json["tipo"]) {
      case "video":
        return Video.fromJson(json);
      case "youtube":
        return Youtube.fromJson(json);
      default:
        return Imagen.fromJson(json);
    }
  }

  @override
  List<Object?> get props => [provider];
}

class Video extends Media {
  final String? previsualizacion;
  const Video({
    this.previsualizacion,
    required super.provider,
  }) : super(tipo: TipoDeMedia.video);

  static Video fromJson(Map<String, dynamic> portada) {
    return Video(
      previsualizacion: portada["previsualizacion"],
      provider: NetworkProvider(path: portada["path"]),
    );
  }
}

class Imagen extends Media {
  const Imagen({required super.provider}) : super(tipo: TipoDeMedia.imagen);

  static Imagen fromJson(Map<String, dynamic> json) {
    return Imagen(
      provider: NetworkProvider(path: json["path"]),
    );
  }
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

  static Youtube fromJson(Map<String, dynamic> json) {
    return Youtube(
      provider: NetworkProvider(path: json["path"]),
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
