import 'dart:developer';
import 'dart:io';

import 'package:blog_app/features/media/presentation/widgets/reproductor_de_video/previsualizacion.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../logic/bloc/reproductor/reproductor_de_video_bloc.dart';
import '../../logic/classes/video_providers.dart';
import 'controles/controles_custom.dart';

class ReproductorDeVideoWidget extends StatefulWidget {
  late final VideoPlayerController controller;
  final ImageProvider? previsualizacion;

  ReproductorDeVideoWidget.fromNetwork({
    super.key,
    required String url,
    this.previsualizacion,
  }) {
    controller = VideoPlayerController.networkUrl(Uri.parse(url));
  }

  ReproductorDeVideoWidget.fromFile({
    super.key,
    required File video,
    this.previsualizacion,
  }) {
    controller = VideoPlayerController.file(video);
  }

  factory ReproductorDeVideoWidget.fromProvider({
    Key? key,
    required VideoProvider provider,
    ImageProvider? previsualizacion,
  }) {
    switch (provider) {
      case NetworkVideoProvider provider:
        return ReproductorDeVideoWidget.fromNetwork(
          key: key,
          url: provider.url,
          previsualizacion: previsualizacion,
        );
      case FileVideoProvider provider:
        return ReproductorDeVideoWidget.fromFile(
          key: key,
          video: provider.file,
          previsualizacion: previsualizacion,
        );
      default:
        throw Exception("Provider invalido");
    }
  }

  @override
  State<ReproductorDeVideoWidget> createState() =>
      _ReproductorDeVideoWidgetState();
}

class _ReproductorDeVideoWidgetState extends State<ReproductorDeVideoWidget> {
  late final ChewieController controller;
  late final ReproductorDeVideoBloc bloc;

  double ratio = 1;

  @override
  void initState() {
    controller = ChewieController(
      videoPlayerController: widget.controller,
      customControls: ChangeNotifierProvider.value(
        value: widget.controller,
        child: const ControlesDeReproductorDeVideo(),
        builder: (context, child) {
          return BlocProvider.value(
            value: bloc,
            child: ChangeNotifierProvider.value(
              value: controller,
              child: child,
            ),
          );
        },
      ),
    );

    bloc = ReproductorDeVideoBloc(controller);

    if (widget.previsualizacion == null) {
      initReproductor();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void listener(BuildContext context, ReproductorDeVideoState state) {
      if (state.reproductor == EstadoDeReproductor.iniciado) {
        setState(() {
          ratio = widget.controller.value.aspectRatio;
        });

        widget.controller.addListener(
          () {
            bloc.add(
              CambiarParametros(
                finalizado: controller.videoPlayerController.value.isCompleted,
                volumen: widget.controller.value.volume,
                reproduciendo: controller.isPlaying,
                buffering: controller.estaBuffereando(),
                position: controller.videoPlayerController.value.position,
              ),
            );
          },
        );

        controller.addListener(() {
          bloc.add(
            CambiarParametros(
              pantalla_completa: controller.isFullScreen,
            ),
          );
        });

        controller.play();
      }
    }

    Widget builder(BuildContext context, ReproductorDeVideoState state) {
      bool mostrarPrevisualizacion() =>
          widget.previsualizacion != null &&
          state.reproductor != EstadoDeReproductor.corriendo;

      if (mostrarPrevisualizacion()) {
        return PrevisualizacionDeVideo(
          previsualizacion: widget.previsualizacion!,
          init: initReproductor,
        );
      }
      return AspectRatio(
        aspectRatio: ratio,
        child: Chewie(controller: controller),
      );
    }

    return BlocProvider.value(
      value: bloc,
      child: BlocListener<ReproductorDeVideoBloc, ReproductorDeVideoState>(
        listener: listener,
        child: BlocBuilder<ReproductorDeVideoBloc, ReproductorDeVideoState>(
          builder: builder,
        ),
      ),
    );
  }

  void initReproductor() {
    bloc.add(const InicializarReproductor());
  }
}
