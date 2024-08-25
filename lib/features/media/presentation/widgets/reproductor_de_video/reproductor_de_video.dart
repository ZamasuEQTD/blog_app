import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

import '../../logic/classes/video_providers.dart';

class ReproductorDeVideoWidget extends StatefulWidget {
  late final VideoPlayerController controller;
  final ImageProvider? previsualizacion;

  ReproductorDeVideoWidget.fromNetwork({super.key, required String url, this.previsualizacion}) {
    controller = VideoPlayerController.networkUrl(Uri.parse(url));
  }

  ReproductorDeVideoWidget.fromFile({super.key, required File video, this.previsualizacion}) {
    controller = VideoPlayerController.file(video);
  }

  factory ReproductorDeVideoWidget.fromProvider({
    Key? key,
    required VideoProvider provider,
    ImageProvider? previsualizacion
  }) {
    switch (provider) {
      case NetworkVideoProvider provider:
        return ReproductorDeVideoWidget.fromNetwork(
          key: key,
          url: provider.url,
          previsualizacion: previsualizacion
        );
      case FileVideoProvider provider:
        return ReproductorDeVideoWidget.fromFile(
          key: key,
          video: provider.file,
          previsualizacion: previsualizacion
        );
      default:
        throw Exception("Provider invalido");
    }
  }

  @override
  State<ReproductorDeVideoWidget> createState() => _ReproductorDeVideoWidgetState();
}

class _ReproductorDeVideoWidgetState extends State<ReproductorDeVideoWidget> {
  late final ChewieController controller;
  double ratio = 1;
  @override
  void initState() {
    controller = ChewieController(
        videoPlayerController: widget.controller,
    );

    widget.controller.initialize().then((value) {
      setState(() {
        ratio = widget.controller.value.aspectRatio;
      });
    }); 

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: ratio,
      child: Chewie(
        controller: controller
      )
    );
  }
} 