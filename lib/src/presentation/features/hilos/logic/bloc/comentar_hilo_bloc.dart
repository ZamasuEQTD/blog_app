import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/src/domain/shared/models/spoileable.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/features/media/models/media.dart';

part 'comentar_hilo_event.dart';
part 'comentar_hilo_state.dart';

class ComentarHiloBloc extends Bloc<ComentarHiloEvent, ComentarHiloState> {
  ComentarHiloBloc() : super(const ComentarHiloState()) {
    on<EnviarComentario>(_onEnviarComentario);
  }

  Future _onEnviarComentario(EnviarComentario event, Emitter<ComentarHiloState> emit)async {
    emit(state.copyWith(
      status: ComentarHiloStatus.enviando
    ));

    await Future.delayed(const Duration(seconds: 5));
  
    emit(state.copyWith(
      status: ComentarHiloStatus.enviado
    ));
  }
}
