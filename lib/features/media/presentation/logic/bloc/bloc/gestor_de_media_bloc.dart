import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/classes/failure.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/models/media.dart';

part 'gestor_de_media_event.dart';
part 'gestor_de_media_state.dart';

class GestorDeMediaBloc extends Bloc<GestorDeMediaEvent, GestorDeMediaState> {
  final int cantidadMaxima;
  GestorDeMediaBloc({
    this.cantidadMaxima = 1,
  }) : super(const GestorDeMediaInitialState()) {
    on<AgregarMedia>(_onAgregarMedia);
    on<EliminarMedia>(_onEliminarMedia);
  }

  bool get _haAlcanzadoCantidadMaxima => state.medias.length == cantidadMaxima;

  void _onAgregarMedia(
    AgregarMedia event,
    Emitter<GestorDeMediaState> emit,
  ) {
    if (cantidadMaxima == 1) {
      emit(
        state.copyWith(
          medias: [event.media],
        ),
      );
      return;
    }

    if (_haAlcanzadoCantidadMaxima) {
      emit(
        GestorDeMediasFailureState(
          error: Failure(
            code: "Media.CantidadMaximaAlcancazad",
            descripcion: "No puedes agregar mas archivos",
          ),
          medias: state.medias,
        ),
      );
      return;
    }

    emit(GestorDeMediaInitialState(medias: [...state.medias, event.media]));
  }

  void _onEliminarMedia(EliminarMedia event, Emitter<GestorDeMediaState> emit) {
    List<Media> medias = state.medias;

    if (cantidadMaxima == 1 || event.index != null) {
      medias = medias.sublist(1);
    } else {
      List<Media> m = [];

      for (var i = 0; i < medias.length; i++) {
        if (i != event.index) {
          m.add(state.medias[i]);
        }
      }

      medias = m;
    }
    emit(GestorDeMediaInitialState(medias: medias));
  }
}
