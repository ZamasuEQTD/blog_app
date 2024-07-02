class YoutubeService {

  static RegExp regExp =RegExp(r"^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})");

  YoutubeService._();
  
  static bool esLinkValido(String url){
    return false;  
  }

  static String? getVideoId(String url) => regExp.firstMatch(url)?.group(1);

  static String getYoutubeThumbnailUrl(String id) => 'https://img.youtube.com/vi/$id/0.jpg';
}