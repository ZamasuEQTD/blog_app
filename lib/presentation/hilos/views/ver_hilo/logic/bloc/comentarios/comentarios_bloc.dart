import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/domain/features/comentarios/entities/comentario.dart';
import 'package:blog_app/domain/features/hilo/usecases/get_comentarios_de_hilo_usecase.dart';
import 'package:equatable/equatable.dart';

part 'comentarios_event.dart';
part 'comentarios_state.dart';

class ComentariosBloc extends Bloc<ComentariosEvent, ComentariosState> {
  final GetComentariosDeHiloUsecase _usecase;
  ComentariosBloc(this._usecase) : super(const ComentariosState()) {
    on<CargarComentarios>(_onCargarComentarios);
    on<EliminarComentario>(_onEliminarComentario);
    on<AgregarComentario>(_onAgregarComentario);
  }

  Future _onCargarComentarios(CargarComentarios event, Emitter<ComentariosState> emit) async {
    emit(state.copyWith(
      status: ComentariosStatus.cargado
    ));
  
    var result = await _usecase.handle(GetComentariosDeHiloRequest());

    result.fold(
      (l) => emit(
        state.copyWith(
          status: ComentariosStatus.failure
        )
      ),
      (r) => emit(
        state.copyWith(
          status: ComentariosStatus.cargados,
          comentarios: [...state.comentarios,...r]
        )
      )
    );
  }

  void _onEliminarComentario(EliminarComentario event, Emitter<ComentariosState> emit) {
    emit(state.copyWith(
      comentarios: state.comentarios.where((c)=> c.id != event.id).toList()
    ));
  }

  void _onAgregarComentario(AgregarComentario event, Emitter<ComentariosState> emit) {
    emit(state.copyWith(
      comentarios : [event.comentario,...state.comentarios]
    ));
  }
}
