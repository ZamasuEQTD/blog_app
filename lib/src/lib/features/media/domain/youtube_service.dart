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

  static bool EsVideoOrShort(String url) => getVideoId(url) != null;
}
