import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/domain/features/comentarios/services/tag_service.dart';
import 'package:blog_app/domain/features/common/entities/spoileable.dart';
import 'package:blog_app/domain/features/hilo/usecases/comentar_hilo_usecase.dart';
import 'package:blog_app/domain/features/media/entities/media.dart';
import 'package:equatable/equatable.dart';

part 'comentar_hilo_event.dart';
part 'comentar_hilo_state.dart';

class ComentarHiloBloc extends Bloc<ComentarHiloEvent, ComentarHiloState> {
  final ComentarHiloUsecase _usecase;
  ComentarHiloBloc(this._usecase) : super(const ComentarHiloState()) {
    on<EnviarComentario>(_onEnviarComentario);
    on<SwitchDeMediaSpoiler>(_onSwitchMediaSpoiler);
    on<AgregarMedia>(_onAgregarMedia);
    on<AggregarTaggueo>(_onAgregarTaggueo);
  }

  void _onSwitchMediaSpoiler(
      SwitchDeMediaSpoiler event, Emitter<ComentarHiloState> emit) {
    emit(state.copyWith(
        media: state.media!.copyWith(spoiler: !state.media!.esSpoiler)));
  }

  void _onAgregarMedia(AgregarMedia event, Emitter<ComentarHiloState> emit) {
    emit(state.copyWith(media: Spoileable(false, event.media)));
  }

  Future _onEnviarComentario(
      EnviarComentario event, Emitter<ComentarHiloState> emit) async {
    emit(state.copyWith(status: ComentarHiloStatus.enviando));

    var result = await _usecase.handle(ComentarHiloRequest());

    result.fold(
      (l) => emit(state.copyWith(status: ComentarHiloStatus.failure)),
      (r) {
        emit(state.copyWith(status: ComentarHiloStatus.enviando));
        emit(const ComentarHiloState());
      },
    );
  }

  void _onAgregarTaggueo(
      AggregarTaggueo event, Emitter<ComentarHiloState> emit) {
    if (!TagService.getTagsUnicos(state.texto).contains(event.tag)) {
      emit(state.copyWith(
        ultimoTaggueo: event.tag
      ));
    }
  }
}
