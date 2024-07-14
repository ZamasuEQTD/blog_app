import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:blog_app/src/application/abstractions/messaging/icommand.dart';
import 'package:blog_app/src/application/abstractions/messaging/icommand_handler.dart';
import 'package:blog_app/src/domain/features/media/models/media.dart';
import 'package:blog_app/src/domain/shared/models/spoileable.dart';
import 'package:blog_app/src/shared_kernel/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'comentar_hilo_event.dart';
part 'comentar_hilo_state.dart';

class ComentarHiloBloc extends Bloc<ComentarHiloEvent, ComentarHiloState> {
  ComentarHiloCommandHandler handler = ComentarHiloCommandHandler();
  
  ComentarHiloBloc() : super(const ComentarHiloState()) {
    on<CambiarTexto>(_onCambiarTexto);
    on<EnviarComentario>(_onEnviarComentario);
  }

  void _onCambiarTexto(CambiarTexto event, Emitter<ComentarHiloState> emit) {
    emit(state.copyWith(
      texto: event.texto 
    ));
  }


  Future _onEnviarComentario(EnviarComentario event, Emitter<ComentarHiloState> emit) async {
    emit(state.copyWith(
      status: ComentarHiloStatus.enviando
    ));

    var result = await handler.handle(ComentarHiloCommand());

    result.fold(
      (l) => emit(state.copyWith(status: ComentarHiloStatus.failure)),
      (r) => emit(state.copyWith(
        media: null,
        texto: "",
        status: ComentarHiloStatus.enviado
      ))
    );

    emit(state.copyWith(
      status: ComentarHiloStatus.initial
    ));
  }
}


class ComentarHiloCommand extends ICommand<Either<Failure,Unit>> {}

class ComentarHiloCommandHandler extends ICommandHandler<ComentarHiloCommand,Either<Failure,Unit>> {
  @override
  Future<Either<Failure, Unit>> handle(ComentarHiloCommand command) async {
    await Future.delayed(const Duration(seconds: 10));
    return const Right(unit);
  }
}