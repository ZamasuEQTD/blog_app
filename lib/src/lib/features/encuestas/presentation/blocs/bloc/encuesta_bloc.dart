import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/src/lib/features/encuestas/domain/models/encuesta.dart';
import 'package:equatable/equatable.dart';

part 'encuesta_event.dart';
part 'encuesta_state.dart';

class EncuestaBloc extends Bloc<EncuestaEvent, EncuestaState> {
  final Encuesta encuesta;
  EncuestaBloc(this.encuesta) : super(EncuestaState(encuesta: encuesta)) {
    on<SeleccionarRespuesta>(_onSeleccionarRespuesta);
    on<SumarVoto>(_onSumarVoto);
  }

  void _onSeleccionarRespuesta(
    SeleccionarRespuesta event,
    Emitter<EncuestaState> emit,
  ) {
    if (state.opcionSeleccionada == event.id) {
      emit(
        state.copyWith(
          opcionSeleccionada: "",
        ),
      );

      return;
    }
    emit(
      state.copyWith(opcionSeleccionada: event.id),
    );
  }

  void _onSumarVoto(SumarVoto event, Emitter<EncuestaState> emit) {
    emit(
      state.copyWith(
        encuesta: encuesta.copyWith(
          votos: state.encuesta.votos + 1,
          respuestas: state.encuesta.respuestas
              .map((e) => e.id == event.id ? e.copyWith(votos: e.votos + 1) : e)
              .toList(),
        ),
      ),
    );
  }
}
