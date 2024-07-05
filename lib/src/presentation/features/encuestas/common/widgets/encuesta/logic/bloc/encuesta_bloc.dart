import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/src/domain/features/encuestas/models/encuesta.dart';
import 'package:equatable/equatable.dart';

part 'encuesta_event.dart';
part 'encuesta_state.dart';

class EncuestaBloc extends Bloc<EncuestaEvent, Encuesta> {
  EncuestaBloc(super.encuesta) {
    on<AgregarVoto>(_onAgregarVoto);
  }

  void _onAgregarVoto(AgregarVoto event, Emitter<Encuesta> emit) {
    emit(state.copyWith(respuestas: state.respuestas.map((e) => e.copyWith(votos: e.id == ""? e.votos + 1 : e.votos)).toList()));
  }
}
