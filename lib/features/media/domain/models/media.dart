// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class Media {
  final MediaProvider provider;
  const Media({
    required this.provider,
  });
}

class Video extends Media {
  final String? previsualizacion;
  const Video({
    this.previsualizacion,
    required super.provider,
  });
}

class Imagen extends Media {
  Imagen({required super.provider});
}

abstract class MediaProvider {
  final String path;
  const MediaProvider({
    required this.path,
  });
}

class NetworkProvider extends MediaProvider {
  const NetworkProvider({required super.path});
}

class FileProvider extends MediaProvider {
  const FileProvider({required super.path});
}

class Youtube extends Video {
  const Youtube(
      {super.previsualizacion, required NetworkProvider super.provider});

  factory Youtube.fromUrl(String url) {
    return Youtube(
        previsualizacion: YoutubeService.miniaturaFromUrl(url),
        provider: NetworkProvider(path: url));
  }
}

class YoutubeService {
  static RegExp youtubeIdRegex =
      RegExp(r'(youtu.*be.*)\/(watch\?v=|embed\/|v|shorts|)(.*?((?=[&#?])|$))');

  static RegExp youtubeLinkRegex = RegExp(
      r'^https?:\/\/(www\.)?youtu(\.be\/|be\.com\/)(watch\?v=|embed\/|v\/|shorts\/)([A-Za-z0-9-_]{11})((?=[&#?])|$)');

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
