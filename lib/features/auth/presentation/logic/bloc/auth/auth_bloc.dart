import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blog_app/features/auth/domain/usecases/cerrar_sesion_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/decode_token_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/establecer_token_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/get_ultima_sesion_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/registro_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../../domain/models/usuario.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(SinSesionInciada()) {
    on<CerrarSesion>(_onCerrarSesion);
    on<IniciarSesion>(_onIniciarSesion);
    on<Registrarse>(_onRegistrarse);
    on<RecuperarUltimaSesion>(_onRecuperarUltimaSesion);
  }

  Future<void> _onCerrarSesion(
      CerrarSesion event, Emitter<AuthState> emit) async {
    CerrarSesionUsecase usecase = GetIt.I.get();

    var res = await usecase.handle(CerrarSesionRequest());

    res.fold((l) => null, (r) => emit(SinSesionInciada()));
  }

  FutureOr<void> _onRecuperarUltimaSesion(
      RecuperarUltimaSesion event, Emitter<AuthState> emit) async {
    GetUltimaSesionUsecase usecase = GetIt.I.get();

    var result = await usecase.handle(GetUltimaSesionRequest());

    result.fold(
      (l) => null,
      (token) async {
        if (token is! Token) {
          return;
        }

        DecodeTokenUsecase usecase = GetIt.I.get();

        var res = await usecase.handle(DecodeTokenRequest(token: token.jwt));

        res.fold(
          (l) {},
          (r) {
            emit(SesionIniciada(token: token, usuario: r));
          },
        );
      },
    );
  }

  FutureOr<void> _onIniciarSesion(
      IniciarSesion event, Emitter<AuthState> emit) async {
    LoginUsecase usecase = GetIt.I.get();

    var result = await usecase
        .handle(LoginRequest(usuario: event.usuario, password: event.password));

    result.fold((l) {}, (token) async {
      DecodeTokenUsecase usecase = GetIt.I.get();

      var result = await usecase.handle(DecodeTokenRequest(token: token));

      result.fold(
        (l) {},
        (usuario) {
          emit(SesionIniciada(token: Token(jwt: token), usuario: usuario));
        },
      );
    });
  }

  FutureOr<void> _onRegistrarse(
      Registrarse event, Emitter<AuthState> emit) async {
    RegistroUsecase usecase = GetIt.I.get();

    var result = await usecase.handle(
        RegistroRequest(usuario: event.usuario, password: event.password));

    result.fold((l) {}, (token) async {
      DecodeTokenUsecase usecase = GetIt.I.get();

      var result = await usecase.handle(DecodeTokenRequest(token: token));

      result.fold(
        (l) {},
        (usuario) {
          emit(SesionIniciada(token: Token(jwt: token), usuario: usuario));
        },
      );
    });
  }
}
