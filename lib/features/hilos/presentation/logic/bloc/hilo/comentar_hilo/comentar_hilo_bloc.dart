import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/nullable.dart';
import 'package:blog_app/features/hilos/domain/services/tag_service.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../../common/logic/classes/spoileable.dart';
import '../../../../../../media/domain/models/media.dart';

part 'comentar_hilo_event.dart';
part 'comentar_hilo_state.dart';

class ComentarHiloBloc extends Bloc<ComentarHiloEvent, ComentarHiloState> {
  ComentarHiloBloc() : super(const ComentarHiloState()) {
    on<CambiarComentario>(_cambiarComentario);
  }

  void _cambiarComentario(
    CambiarComentario event,
    Emitter<ComentarHiloState> emit,
  ) {
    emit(state.copyWith(texto: event.comentario));
  }
}
