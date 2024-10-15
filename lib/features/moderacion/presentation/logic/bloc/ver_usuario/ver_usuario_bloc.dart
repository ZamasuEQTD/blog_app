import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/features/moderacion/domain/models/vista_de_usuario.dart';
import 'package:equatable/equatable.dart';

import '../../../../../home/domain/models/home_portada_entry.dart';

part 'ver_usuario_event.dart';
part 'ver_usuario_state.dart';

class VerUsuarioBloc extends Bloc<VerUsuarioEvent, VerUsuarioState> {
  final String usuario;
  VerUsuarioBloc(this.usuario) : super(VerUsuarioInitial()) {
    on<CambiarTipoDeHistorial>(_onCambiarHistorial);
    on<CargarUsuario>(
      (event, emit) {},
    );
  }

  void _onCambiarHistorial(
    CambiarTipoDeHistorial event,
    Emitter<VerUsuarioState> emit,
  ) {
    emit(state.copyWith(tipoDeHistorial: event.tipo));
  }
}
