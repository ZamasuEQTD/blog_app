import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/src/lib/features/auth/domain/iauth_repository.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthRepository _authRepository = GetIt.I.get();

  LoginBloc() : super(const LoginState()) {
    on<Loguearse>(_onIniciarSesion);
  }

  FutureOr<void> _onIniciarSesion(
    Loguearse event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        form: const LoginFormStatus.enviando(),
      ),
    );

    var response = await _authRepository.login(
      password: state.password,
      usuario: state.username,
    );

    response.fold(
      (l) => emit(
        state.copyWith(
          form: LoginFormStatus.fallido(failure: l),
        ),
      ),
      (r) => emit(
        state.copyWith(
          form: LoginFormStatus.enviado(token: r),
        ),
      ),
    );
  }
}
