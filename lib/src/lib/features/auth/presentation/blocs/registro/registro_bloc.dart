import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/src/lib/features/auth/domain/iauth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../../../utils/clases/failure.dart';

part 'registro_event.dart';
part 'registro_state.dart';

class RegistroBloc extends Bloc<RegistroEvent, RegistroState> {
  final IAuthRepository _repository = GetIt.I.get();
  RegistroBloc() : super(const RegistroState()) {
    on<Registrarse>(_onRegistrarse);
  }

  FutureOr<void> _onRegistrarse(
    Registrarse event,
    Emitter<RegistroState> emit,
  ) async {
    emit(
      state.copyWith(
        form: const RegistroFormStatus.registrando(),
      ),
    );
    var response = await _repository.registro();

    response.fold(
      (l) => null,
      (r) => emit(
        state.copyWith(
          form: RegistroFormStatus.enviado(token: r),
        ),
      ),
    );
  }
}
