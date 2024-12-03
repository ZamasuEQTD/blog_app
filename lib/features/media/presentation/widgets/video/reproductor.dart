import 'dart:io';

import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:blog_app/features/media/presentation/widgets/video/logic/controller/video_controller.dart';
import 'package:blog_app/features/media/presentation/widgets/video/widgets/controles/controles_de_reproductor.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'logic/providers/video_provider.dart';
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
  late final VideoController _controller;

  bool get _previsualizacionVisible =>
      widget.previsualizacion != null &&
      _controller.reproductorStatus.value != ReproductorStatus.iniciado;

  @override
  void initState() {
    _controller = VideoController();

    chewie = ChewieController(
      videoPlayerController: widget.controller,
      customControls: ChangeNotifierProvider.value(
        value: widget.controller,
        builder: (context, child) {
          return ChangeNotifierProvider.value(
            value: chewie,
            child: ListenableProvider.value(
              value: _controller,
              child: const ControlesDeReproductorLayout(),
            ),
          );
        },
      ),
    );

    if (widget.previsualizacion == null) {
      widget.controller.initialize();
    }

    void listener() {
      if (widget.controller.value.isInitialized) {
        _controller.aspectRatio.value = widget.controller.value.aspectRatio;

        _controller.reproductorStatus.value = ReproductorStatus.iniciado;

        widget.controller.removeListener(listener);
      }
    }

    widget.controller.addListener(listener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableProvider.value(
      value: _controller,
      child: GetBuilder(
        global: false,
        init: _controller,
        builder: (controller) {
          return Obx(() {
            if (_previsualizacionVisible) {
              return Previsualizacion(
                controller: widget.controller,
                previsualizacion: widget.previsualizacion!,
              );
            }

            return AspectRatio(
              aspectRatio: _controller.aspectRatio.value ?? 1,
              child: Chewie(controller: chewie),
            );
          });
        },
      ),
    );
  }
}
