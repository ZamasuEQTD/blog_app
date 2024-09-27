import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:video_player/video_player.dart';

part 'reproductor_de_video_event.dart';
part 'reproductor_de_video_state.dart';

class ReproductorDeVideoBloc
    extends Bloc<ReproductorDeVideoEvent, ReproductorDeVideoState> {
  final ChewieController controller;

  ReproductorDeVideoBloc(this.controller)
      : super(const ReproductorDeVideoState()) {
    on<AddListeners>(_addListeners);
    on<FinalizarVideo>(_onFinalizarVideo);
    on<ReproducirVideo>(_onReproducirVideo);
    on<PausarVideo>(_onPausarVideo);
    on<InicializarReproductor>(_onInicializarReproductor);
    add(AddListeners());
  }

  FutureOr<void> _onInicializarReproductor(
    InicializarReproductor event,
    Emitter<ReproductorDeVideoState> emit,
  ) async {
    emit(state.copyWith(reproductor: EstadoDeReproductor.iniciando));
    try {
      await controller.videoPlayerController.initialize();
      emit(state.copyWith(reproductor: EstadoDeReproductor.iniciado));
    } catch (e) {
      emit(state.copyWith(reproductor: EstadoDeReproductor.fallido));
    }
  }

  FutureOr<void> _onFinalizarVideo(
    FinalizarVideo event,
    Emitter<ReproductorDeVideoState> emit,
  ) {
    emit(state.copyWith(reproduccion: EstadoDeReproduccion.finalizado));
  }

  FutureOr<void> _onReproducirVideo(
      ReproducirVideo event, Emitter<ReproductorDeVideoState> emit) {
    if (state.reproduccion == EstadoDeReproduccion.finalizado) {
    } else {
      emit(state.copyWith(reproduccion: EstadoDeReproduccion.reproduciendo));
    }
  }

  FutureOr<void> _onPausarVideo(
      PausarVideo event, Emitter<ReproductorDeVideoState> emit) {
    emit(state.copyWith(reproduccion: EstadoDeReproduccion.pausado));
  }

  void _addListeners(
    AddListeners event,
    Emitter<ReproductorDeVideoState> emit,
  ) {
    EstadoDeReproduccion reproduccion() {
      if (controller.estaFinalizado()) {
        return EstadoDeReproduccion.finalizado;
      }
      if (controller.isPlaying) {
        return EstadoDeReproduccion.reproduciendo;
      }
      return EstadoDeReproduccion.pausado;
    }

    controller.addListener(
      () => emit(
        state.copyWith(volumen: controller.videoPlayerController.value.volume),
      ),
    );

    controller.addListener(
      () => emit(
        state.copyWith(
          reproductor: controller.videoPlayerController.value.isInitialized
              ? EstadoDeReproductor.iniciado
              : EstadoDeReproductor.iniciando,
        ),
      ),
    );

    controller.addListener(
      () => emit(
        state.copyWith(
          pantalla: controller.isFullScreen
              ? EstadoDePantalla.completa
              : EstadoDePantalla.normal,
        ),
      ),
    );

    controller.addListener(
      () => emit(
        state.copyWith(
            buffer: controller.estaBuffereando()
                ? EstadoDeBuffer.cargando
                : EstadoDeBuffer.cargado),
      ),
    );

    controller.addListener(
      () => emit(
        state.copyWith(
          reproduccion: reproduccion(),
        ),
      ),
    );

    controller.addListener(
      () => emit(
        state.copyWith(
          position: controller.videoPlayerController.value.position,
        ),
      ),
    );
  }
}

extension VideoPlayerControllerExtensions on VideoPlayerController {
  void retroceder(Duration time) {
    seekTo(value.position - time);
  }

  void adelantar(Duration time) {
    seekTo(value.position + time);
  }
}

extension ChewieExtensions on ChewieController {
  bool estaFinalizado() {
    return videoPlayerController.value.isCompleted;
  }

  bool debeFinalizar() {
    return !estaFinalizado() && videoPlayerController.value.isCompleted;
  }

  bool estaBuffereando() {
    return videoPlayerController.value.isBuffering;
  }

  bool debeBufferear() {
    return !estaBuffereando() && videoPlayerController.value.isBuffering;
  }

  void retroceder(Duration time) {
    videoPlayerController.seekTo(videoPlayerController.value.position - time);
  }

  void adelantar(Duration time) {
    videoPlayerController.seekTo(videoPlayerController.value.position + time);
  }
}
