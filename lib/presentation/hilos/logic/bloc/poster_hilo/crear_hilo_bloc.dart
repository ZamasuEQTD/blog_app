import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/domain/features/common/entities/spoileable.dart';
import 'package:blog_app/domain/features/hilo/entities/hilo.dart';
import 'package:blog_app/domain/features/hilo/usecases/postear_hilo_usecase.dart';
import 'package:blog_app/domain/features/media/entities/media.dart';
import 'package:equatable/equatable.dart';

part 'crear_hilo_event.dart';
part 'crear_hilo_state.dart';

class CrearHiloBloc extends Bloc<CrearHiloEvent, CrearHiloState> {
  final PostearHiloUsecase _postearHiloUsecase;
  CrearHiloBloc(this._postearHiloUsecase) : super(const CrearHiloState()) {
    on<CambiarBanderas>(_onCambiarBanderas);
    on<CambiarTitulo>(_onCambiarTitulo);
    on<AgregarMedia>(_onAgregarMedia);
    on<EliminarMedia>(_onEliminarMedia);
    on<PostearHilo>(_onPostearHilo);
    on<SwitchSpoiler>(_onSwitchSpoiler);
  }

  void _onCambiarBanderas(CambiarBanderas event, Emitter<CrearHiloState> emit) {
    emit(
      state.copyWith(banderas:state.banderas.copyWith(
        dados: event.dados,
        tagUnico: event.tagUnico
      ))
    );
  }

  void _onCambiarTitulo(CambiarTitulo event, Emitter<CrearHiloState> emit) {
    emit(state.copyWith(
      titulo: event.titulo
    ));
  }

  void _onAgregarMedia(AgregarMedia event, Emitter<CrearHiloState> emit) {
    state.copyWith(
      portada: Spoileable(false, event.media)
    );
  }

  void _onEliminarMedia(EliminarMedia event, Emitter<CrearHiloState> emit) {
    emit(state.copyWith(
      portada: null
    ));
  }

  Future _onPostearHilo(PostearHilo event, Emitter<CrearHiloState> emit) async {
    emit(state.copyWith(
      status: PostearHiloStatus.posteando
    ));

    var result = await _postearHiloUsecase.handle(PostearHiloRequest());
    
    result.fold(
      (l) => emit(
        state.copyWith(status: PostearHiloStatus.failure)
      ),
      (r) => emit(
        state.copyWith(
          status: PostearHiloStatus.posteado,
          hiloId: r
        )
      )
    );
  }

  void _onSwitchSpoiler(SwitchSpoiler event, Emitter<CrearHiloState> emit) {
    emit(state.copyWith(
      portada: state.portada!.copyWith(
        spoiler: !state.portada!.esSpoiler
      )
    ));
  }
}
