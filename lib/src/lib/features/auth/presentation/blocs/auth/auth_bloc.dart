import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/src/lib/features/auth/domain/itoken_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../../usuarios/domain/models/usuario.dart';
import '../../../domain/itoken_decode.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ITokenDecode _tokenService = GetIt.I.get();
  final ITokenStorage _tokenStorage = GetIt.I.get();
  AuthBloc() : super(const AuthInitial()) {
    on<IniciarSesion>(_onIniciarSesion);
    on<RestaurarSesion>(_onRestaurarSesion);
    on<CerrarSesion>(_onCerrarSesion);
  }

  FutureOr<void> _onIniciarSesion(
    IniciarSesion event,
    Emitter<AuthState> emit,
  ) async {
    emit(const IniciandoSesion());

    await _tokenStorage.guardar(event.token);

    Usuario usuario = await _tokenService.decode(event.token);

    emit(SesionIniciada(usuario: usuario));
  }

  FutureOr<void> _onRestaurarSesion(
    RestaurarSesion event,
    Emitter<AuthState> emit,
  ) async {
    String? usuario = await _tokenStorage.recuperar();

    if (usuario != null) {
      emit(SesionIniciada(usuario: await _tokenService.decode(usuario)));
    } else {
      emit(const SinSesion());
    }
  }

  FutureOr<void> _onCerrarSesion(
    CerrarSesion event,
    Emitter<AuthState> emit,
  ) async {
    await _tokenStorage.eliminar();

    emit(const AuthState.sinSesion());
  }
}
