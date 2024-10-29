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
  late final ChewieController controller;
  late final ReproductorDeVideoController _controller =
      ReproductorDeVideoController(
    controller: controller,
  );
  bool get hayPrevisualizacion => widget.previsualizacion != null;

  bool get mostrarPrevisualizacion =>
      !hayPrevisualizacion ||
      _controller.reproductor.value != EstadoDeReproductor.iniciado;

  @override
  void initState() {
    controller = ChewieController(
      videoPlayerController: widget.controller,
      customControls: const ControlesDeReproductorDeVideo(),
    );

    if (!hayPrevisualizacion) {
      _controller.iniciar();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (mostrarPrevisualizacion) {
        return PrevisualizacionDeVideo(
          previsualizacion: widget.previsualizacion!,
          init: _controller.iniciar,
          estado: _controller.reproductor.value,
        );
      }

      return AspectRatio(
        aspectRatio: _controller.aspectRatio.value!,
        child: Chewie(controller: controller),
      );
    });
  }
}
