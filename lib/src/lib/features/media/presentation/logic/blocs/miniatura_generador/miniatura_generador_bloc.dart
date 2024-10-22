import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';

import 'package:blog_app/src/lib/features/app/domain/abstractions/istrategy_context.dart';
import 'package:blog_app/src/lib/features/media/data/file_picker_gallery_service.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:video_compress/video_compress.dart';

import '../../../../domain/iminiatura_video_service.dart';
import '../../../../domain/models/media.dart';
import '../../../../domain/youtube_service.dart';

part 'miniatura_generador_event.dart';
part 'miniatura_generador_state.dart';

class MiniaturaGeneradorBloc
    extends Bloc<MiniaturaGeneradorEvent, MiniaturaGeneradorState> {
  final IStrategyContext _strategyContext = GetIt.I.get();

  MiniaturaGeneradorBloc() : super(MiniaturaGeneradorInitial()) {
    on<GenerarMiniatura>(_onGenerarMiniatura);
  }

  Future<void> _onGenerarMiniatura(
    GenerarMiniatura event,
    Emitter<MiniaturaGeneradorState> emit,
  ) async {
    emit(GenerandoMiniatura());

    Imagen miniatura =
        await _strategyContext.execute<String, Imagen, IMiniaturaStrategy>(
      event.media.tipo.value,
      event.media.provider.path,
    );

    emit(MiniaturaGenerada(miniatura: miniatura));
  }
}

abstract class IMiniaturaStrategy extends IStrategy<String, Imagen> {}

class VideoMiniaturaStrategy extends IMiniaturaStrategy {
  final IMiniaturaVideoGenerador _generador;

  VideoMiniaturaStrategy(this._generador);
  @override
  Future<Imagen> execute(String input) {
    return _generador.generar(input);
  }
}

class ImagenMiniaturaStrategy extends IMiniaturaStrategy {
  @override
  Future<Imagen> execute(String input) {
    return Future.value(Imagen(provider: FileProvider(path: input)));
  }
}

class YoutubeMiniaturaStrategy extends IMiniaturaStrategy {
  @override
  Future<Imagen> execute(String path) {
    return Future.value(
      Imagen(
        provider: NetworkProvider(path: YoutubeService.miniaturaFromUrl(path)),
      ),
    );
  }
}
