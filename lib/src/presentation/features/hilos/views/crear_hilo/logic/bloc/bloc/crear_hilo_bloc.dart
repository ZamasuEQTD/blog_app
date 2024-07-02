import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'crear_hilo_event.dart';
part 'crear_hilo_state.dart';

class CrearHiloBloc extends Bloc<CrearHiloEvent, CrearHiloState> {
  CrearHiloBloc() : super(const CrearHiloState()) {
    on<CambiarBanderas>(_onCambiarBanderas);
    on<CambiarTitulo>(_onCambiarTitulo);
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
}
