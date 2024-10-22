import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:blog_app/features/media/presentation/widgets/miniatura/miniatura.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import 'package:blog_app/src/lib/features/media/domain/models/media.dart';

part 'miniatura_generador_event.dart';
part 'miniatura_generador_state.dart';

class MiniaturaGeneradorBloc
    extends Bloc<MiniaturaGeneradorEvent, MiniaturaGeneradorState> {
  final MiniaturaStrategyContext strategyContext = GetIt.I.get();

  MiniaturaGeneradorBloc() : super(MiniaturaGeneradorInitial()) {
    on<GenerarMiniatura>(_onGenerarMiniatura);
  }

  Future<void> _onGenerarMiniatura(
    GenerarMiniatura event,
    Emitter<MiniaturaGeneradorState> emit,
  ) async {
    emit(GenerandoMiniatura());

    Imagen miniatura = await strategyContext.execute(
      event.media.tipo.value,
      event.media.provider.path,
    );

    emit(MiniaturaGenerada(miniatura: miniatura));
  }
}
