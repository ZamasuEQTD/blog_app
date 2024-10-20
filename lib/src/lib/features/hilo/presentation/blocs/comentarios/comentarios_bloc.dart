import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/icomentarios_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../../comentarios/domain/models/comentario.dart';

part 'comentarios_event.dart';
part 'comentarios_state.dart';

class ComentariosBloc extends Bloc<ComentariosEvent, ComentariosState> {
  final IComentariosRepository _comentariosRepository = GetIt.I.get();
  final String id;
  DateTime? ultimoComentario;

  ComentariosBloc(this.id) : super(const ComentariosState()) {
    on<CargarComentarios>(_onCargarComentarios);
  }

  FutureOr<void> _onCargarComentarios(
    CargarComentarios event,
    Emitter<ComentariosState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ComentariosStatus.cargando,
      ),
    );

    await _comentariosRepository.getComentarios(
      hilo: id,
      ultimoComentario: ultimoComentario,
    );
  }
}
