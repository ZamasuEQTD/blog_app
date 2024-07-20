import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/data/features/auth/models/login_request.dart';
import 'package:blog_app/domain/features/auth/entities/usuario.dart';
import 'package:blog_app/domain/features/auth/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'login_event.dart';
part 'login_state.dart';

var locator = GetIt.I;


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase _usecase = locator.get();
  LoginBloc() : super(const LoginState()) {
    on<Loguearse>(_onLoguearse);
  }

  Future _onLoguearse(Loguearse event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
      status: LoginStatus.logueando
    ));

    var result = await _usecase.handle(LoginRequest(username: state.password, password: state.username));

    result.fold((l) => emit(state.copyWith(
      status: LoginStatus.failure,
    )),
    (r) => emit(
      state.copyWith(
        status: LoginStatus.logueado,
        usuario: r
      )
    ));
  }
}
