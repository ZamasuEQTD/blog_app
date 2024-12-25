import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:blog_app/features/media/domain/services/youtube_service.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeReproductor extends StatefulWidget {
  final Youtube video;
  const YoutubeReproductor({super.key, required this.video});

  @override
  State<YoutubeReproductor> createState() => _YoutubeReproductorState();
}

class _YoutubeReproductorState extends State<YoutubeReproductor> {
  late final YoutubePlayerController controller = YoutubePlayerController(
    initialVideoId: YoutubeService.getVideoId(widget.video.provider.path)!,
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: controller,
    );
  }
}
