import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/models/usuario.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(SinSesionInciada()) {
    on<IniciarSesion>(_onIniciarSesion);
    on<CerrarSesion>(_onCerrarSesion);
  }

  void _onIniciarSesion(IniciarSesion event, Emitter<AuthState> emit) {
    emit(SesionIniciada(usuario: event.usuario));
  }

  void _onCerrarSesion(CerrarSesion event, Emitter<AuthState> emit) {
    emit(CerrandoSesion());
    emit(SinSesionInciada());
  }
}
