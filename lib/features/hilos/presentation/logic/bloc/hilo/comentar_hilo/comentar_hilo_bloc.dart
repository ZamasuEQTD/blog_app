import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/nullable.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../../common/logic/classes/spoileable.dart';
import '../../../../../../media/domain/models/media.dart';
import '../../../../../domain/services/tag_service.dart';

part 'comentar_hilo_event.dart';
part 'comentar_hilo_state.dart';

class ComentarHiloBloc extends Bloc<ComentarHiloEvent, ComentarHiloState> {
  ComentarHiloBloc() : super(const ComentarHiloState()) {
    on<CambiarComentario>(_cambiarComentario);
    on<AggregarTaggueo>(_agregarTaggueo);
    on<AgregarMedia>(_onAgregarMedia);
  }

  void _cambiarComentario(
    CambiarComentario event,
    Emitter<ComentarHiloState> emit,
  ) {
    emit(state.copyWith(texto: event.comentario));
  }

  void _agregarTaggueo(
    AggregarTaggueo event,
    Emitter<ComentarHiloState> emit,
  ) {
    List<String> tags = TagService.getTags(state.texto);

    if (tags.length == 5 || tags.contains(event.tag)) {
      return;
    }

    emit(state.copyWith(taggueo: event.tag));
  }

  void _onAgregarMedia(AgregarMedia event, Emitter<ComentarHiloState> emit) {
    emit(
      state.copyWith(
        media: Nullable(Spoileable(false, event.media)),
      ),
    );
  }
}
