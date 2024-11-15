import 'package:video_player/video_player.dart';

extension VideoPlayerControllerExtension on VideoPlayerController {
  bool get haFinalizado => value.duration == value.position;

  Future<void> replay() async {
    await seekTo(Duration.zero);
    await play();
  }
}
