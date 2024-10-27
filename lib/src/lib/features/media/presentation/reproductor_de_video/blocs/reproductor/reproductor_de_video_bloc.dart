import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

part 'reproductor_de_video_event.dart';
part 'reproductor_de_video_state.dart';

class ReproductorDeVideoBloc
    extends Bloc<ReproductorDeVideoEvent, ReproductorDeVideoState> {
  final ChewieController controller;

  ReproductorDeVideoBloc(this.controller)
      : super(const ReproductorDeVideoState()) {
    on<ToggleControls>(_toggleControls);
    on<CambiarParametros>(_cambiarParametros);
    on<InicializarReproductor>(_onInicializarReproductor);
    on<SwitchReproduccion>(_onSwitchReproduccion);
    on<ReproducirVideo>(_onReproducirVideo);
    on<PausarVideo>(_onPausarVideo);
  }

  FutureOr<void> _onInicializarReproductor(
    InicializarReproductor event,
    Emitter<ReproductorDeVideoState> emit,
  ) async {
    emit(state.copyWith(reproductor: EstadoDeReproductor.iniciando));
    try {
      await controller.videoPlayerController.initialize();
      emit(state.copyWith(reproductor: EstadoDeReproductor.iniciado));
      emit(state.copyWith(reproductor: EstadoDeReproductor.corriendo));
    } catch (e) {
      emit(state.copyWith(reproductor: EstadoDeReproductor.fallido));
    }
  }

  void _toggleControls(
    ToggleControls event,
    Emitter<ReproductorDeVideoState> emit,
  ) {
    emit(
      state.copyWith(mostrar_controles: !state.mostrar_controles),
    );
  }

  void _cambiarParametros(
    CambiarParametros event,
    Emitter<ReproductorDeVideoState> emit,
  ) {
    emit(
      state.copyWith(
        buffering: event.buffering,
        pantalla_completa: event.pantalla_completa,
        position: event.position,
        volumen: event.volumen,
        reproductor: event.reproductor,
        reproduciendo: event.reproduciendo,
      ),
    );
  }

  FutureOr<void> _onSwitchReproduccion(
    SwitchReproduccion event,
    Emitter<ReproductorDeVideoState> emit,
  ) {
    if (state.finalizado || !state.reproduciendo) {
      add(const ReproducirVideo());
    } else {
      add(const PausarVideo());
    }
  }

  FutureOr<void> _onReproducirVideo(
    ReproducirVideo event,
    Emitter<ReproductorDeVideoState> emit,
  ) async {
    await controller.play();
    emit(
      state.copyWith(
        reproduciendo: true,
      ),
    );
  }

  FutureOr<void> _onPausarVideo(
    PausarVideo event,
    Emitter<ReproductorDeVideoState> emit,
  ) async {
    await controller.pause();
    emit(
      state.copyWith(
        reproduciendo: false,
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
