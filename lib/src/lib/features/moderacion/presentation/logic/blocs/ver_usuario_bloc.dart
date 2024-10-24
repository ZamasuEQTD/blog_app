import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/imoderacion_service.dart';
import '../../../domain/models/registro_de_comentario.dart';
import '../../../domain/models/registro_de_hilo.dart';
import '../../../domain/models/usuario.dart';

part 'ver_usuario_event.dart';
part 'ver_usuario_state.dart';

class VerUsuarioBloc extends Bloc<VerUsuarioEvent, VerUsuarioState> {
  final String usuario;

  final IModeracionRepository _repository = GetIt.I.get();

  VerUsuarioBloc(this.usuario) : super(VerUsuarioInitial()) {
    on<CambiarTipoDeHistorial>(_onCambiarHistorial);
    on<CargarUsuario>(_onCargarUsuario);
  }

  void _onCambiarHistorial(
    CambiarTipoDeHistorial event,
    Emitter<VerUsuarioState> emit,
  ) {
    emit(state.copyWith(tipoDeHistorial: event.tipo));
  }

  FutureOr<void> _onCargarUsuario(
    CargarUsuario event,
    Emitter<VerUsuarioState> emit,
  ) async {
    emit(state.copyWith(usuarioState: UsuarioState.cargando));

    var response = await _repository.verUsuario(usuario: usuario);

    response.fold(
      (l) {},
      (r) {
        emit(
          state.copyWith(
            usuario: r,
            usuarioState: UsuarioState.cargado,
          ),
        );
      },
    );
  }
}
