import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:blog_app/src/lib/features/media/presentation/logic/reproductor_de_video_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'providers/video_provider.dart';
import 'widgets/controles/controles_custom.dart';
import 'widgets/previsualizacion.dart';

class ReproductorDeVideo extends StatefulWidget {
  late final VideoPlayerController controller;
  final ImageProvider? previsualizacion;

  ReproductorDeVideo.network({
    super.key,
    required String url,
    this.previsualizacion,
  }) {
    controller = VideoPlayerController.networkUrl(Uri.parse(url));
  }

  ReproductorDeVideo.file({
    super.key,
    required File video,
    this.previsualizacion,
  }) {
    controller = VideoPlayerController.file(video);
  }

  factory ReproductorDeVideo.provider({
    Key? key,
    required VideoProvider provider,
    ImageProvider? previsualizacion,
  }) {
    switch (provider) {
      case NetworkVideoProvider provider:
        return ReproductorDeVideo.network(
          key: key,
          url: provider.url,
          previsualizacion: previsualizacion,
        );
      case FileVideoProvider provider:
        return ReproductorDeVideo.file(
          key: key,
          video: provider.file,
          previsualizacion: previsualizacion,
        );
      default:
        throw Exception("Provider invalido");
    }
  }

  @override
  State<ReproductorDeVideo> createState() => _ReproductorDeVideoState();
}

class _ReproductorDeVideoState extends State<ReproductorDeVideo> {
  late final ChewieController chewie;
  late final ReproductorDeVideoController _controller;

  bool get hayPrevisualizacion => widget.previsualizacion != null;

  bool get mostrarPrevisualizacion =>
      !hayPrevisualizacion ||
      _controller.reproductor.value != EstadoDeReproductor.iniciado;

  @override
  void initState() {
    chewie = ChewieController(
      videoPlayerController: widget.controller,
      customControls: const ControlesDeReproductorDeVideo(),
    );

    _controller = ReproductorDeVideoController();

    if (!hayPrevisualizacion) {
      iniciar();
    }

    chewie.addListener(() {
      _controller.pantalla_completa.value = chewie.isFullScreen;
    });

    super.initState();
  }

  void iniciar() => _controller.iniciar(widget.controller);

  @override
  Widget build(BuildContext context) {
    return VideoControllerProvider(
      controller: _controller,
      child: Obx(() {
        if (mostrarPrevisualizacion) {
          return PrevisualizacionDeVideo(
            previsualizacion: widget.previsualizacion!,
            init: iniciar,
            estado: _controller.reproductor.value,
          );
        }

        return AspectRatio(
          aspectRatio: _controller.aspectRatio.value!,
          child: Chewie(controller: chewie),
        );
      }),
    );
  }
}
