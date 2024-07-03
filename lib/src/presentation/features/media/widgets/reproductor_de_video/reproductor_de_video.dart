import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

import '../../../../../domain/features/media/models/fuente_de_archivo.dart';
import '../../../../../domain/features/media/models/media.dart';

class ReproductorDeVideoWidget extends StatefulWidget {
  late final VideoPlayerController controller;
  final ImageProvider? previsualizacion;

  ReproductorDeVideoWidget.fromNetwork({super.key, required String url, this.previsualizacion}) {
    controller = VideoPlayerController.networkUrl(Uri.parse(url));
  }

  ReproductorDeVideoWidget.fromFile({super.key, required File video, this.previsualizacion}) {
    controller = VideoPlayerController.file(video);
  }

  factory ReproductorDeVideoWidget.fromVideoMedia({
    Key? key,
    required Video video,
    ImageProvider? previsualizacion
  }) {
    if(video.fuente is LocalFile) {
      return ReproductorDeVideoWidget.fromFile(video: (video.fuente as LocalFile).file);
    }
    return ReproductorDeVideoWidget.fromNetwork(url: (video.fuente as NetworkMedia).url);
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