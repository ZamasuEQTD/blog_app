import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/data/features/auth/models/registro_request.dart';
import 'package:blog_app/domain/features/auth/entities/usuario.dart';
import 'package:blog_app/domain/features/auth/usecases/registro_usecase.dart';
import 'package:blog_app/presentation/auth/logic/bloc/login/login_bloc.dart';
import 'package:equatable/equatable.dart';

part 'registro_event.dart';
part 'registro_state.dart';

class RegistroBloc extends Bloc<RegistroEvent, RegistroState> {
  RegistroUsecase _usecase = locator.get();
  RegistroBloc() : super(const RegistroState()) {
    on<Registrarse>(_onRegistrarse);
  }

  Future _onRegistrarse(Registrarse event, Emitter<RegistroState> emit) async{
    emit(state.copyWith(
      status: RegistroStatus.registrando
    ));
    
    var result = await _usecase.handle(RegistroRequest(username: state.username, password: state.passwordRepetida));
  
  }
}
