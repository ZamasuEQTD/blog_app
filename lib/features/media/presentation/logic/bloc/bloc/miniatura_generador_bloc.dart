import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/features/media/domain/usecases/generar_miniatura_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'miniatura_generador_event.dart';
part 'miniatura_generador_state.dart';

class MiniaturaGeneradorBloc
    extends Bloc<MiniaturaGeneradorEvent, MiniaturaGeneradorState> {
  final String path;
  final GenerarMiniaturaUsecase _generar = GetIt.I.get();
  MiniaturaGeneradorBloc(this.path) : super(MiniaturaGeneradorInitial()) {
    on<GenerarMiniatura>(_onGenerarMiniatura);
  }

  Future<void> _onGenerarMiniatura(
      GenerarMiniatura event, Emitter<MiniaturaGeneradorState> emit) async {
    emit(GenerandoMiniatura());

    var result = await _generar.handle(path);

    result.fold((l) => null, (r) => emit(MiniaturaGenerada(path: r)));
  }
}
