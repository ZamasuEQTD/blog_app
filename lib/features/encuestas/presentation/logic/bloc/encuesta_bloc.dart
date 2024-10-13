import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/nullable.dart';
import 'package:blog_app/features/encuestas/domain/models/encuesta.dart';
import 'package:equatable/equatable.dart';

part 'encuesta_event.dart';
part 'encuesta_state.dart';

class EncuestaBloc extends Bloc<EncuestaEvent, EncuestaState> {
  EncuestaBloc(Encuesta encuesta) : super(EncuestaState(encuesta: encuesta)) {
    on<AgregarVoto>(_onAgregarVoto);
    on<SeleccionarOpcion>(_onSeleccionarOpcion);
  }

  void _onAgregarVoto(AgregarVoto event, Emitter<EncuestaState> emit) {
    Encuesta encuesta = state.encuesta;
    List<OpcionDeEncuesta> opciones = encuesta.opciones;
    emit(
      state.copyWith(
        encuesta: encuesta.copyWith(
          opciones: opciones
              .map(
                (e) => e.id == event.id ? e.copyWith(votos: e.votos + 1) : e,
              )
              .toList(),
        ),
      ),
    );
  }

  void _onSeleccionarOpcion(
    SeleccionarOpcion event,
    Emitter<EncuestaState> emit,
  ) {
    if (event.id == state.opcionSeleccionada) {
      emit(state.copyWith(opcionSeleccionada: const Nullable(null)));
    } else {
      emit(state.copyWith(opcionSeleccionada: Nullable(event.id)));
    }
  }
}
