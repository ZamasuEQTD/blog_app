import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/icomentarios_repository.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/src/lib/features/hilo/domain/ihilos_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../../comentarios/domain/models/comentario.dart';
import '../../../domain/models/hilo.dart';

part 'hilo_event.dart';
part 'hilo_state.dart';

class HiloBloc extends Bloc<HiloEvent, HiloState> {
  final String id;
  final IHilosRepository _hilosRepository = GetIt.I.get();
  final IComentariosRepository _comentariosRepository = GetIt.I.get();
  HiloBloc(this.id) : super(const HiloState()) {
    on<RecargarHilo>(_onRecargarHilo);
    on<CargarHilo>(_onCargarHilo);
    on<EliminarHilo>(_onEliminarHilo);
    on<CargarComentarios>(_onCargarComentarios);
    on<EliminarComentario>(_onEliminarComentario);
    on<AgregarComentario>(_onAgregarComentario);
  }

  void _onRecargarHilo(RecargarHilo event, Emitter<HiloState> emit) {
    emit(const HiloState());
    add(CargarHilo());
  }

  Future _onCargarHilo(CargarHilo event, Emitter<HiloState> emit) async {
    emit(state.copyWith(status: HiloStatus.cargando));

    var result = await _hilosRepository.getHilo(id: id);

    result.fold(
      (l) => emit(state.copyWith(status: HiloStatus.initial)),
      (r) => emit(
        state.copyWith(hilo: r, status: HiloStatus.cargado),
      ),
    );
  }

  void _onEliminarHilo(EliminarHilo event, Emitter<HiloState> emit) {
    emit(
      state.copyWith(
        hilo: state.hilo!.copyWith(estado: EstadoDeHilo.eliminado),
      ),
    );
  }

  FutureOr<void> _onCargarComentarios(
    CargarComentarios event,
    Emitter<HiloState> emit,
  ) async {
    if (state.comentariosState is CargandoComentariosState) return;

    emit(
      state.copyWith(
        comentariosState: const ComentariosState.cargando(),
      ),
    );

    var result = await _comentariosRepository.getComentarios(hilo: id);

    result.fold(
      (l) {
        emit(
          state.copyWith(),
        );
      },
      (r) {
        emit(
          state.copyWith(
            comentariosState: ComentariosState.cargados(comentarios: r),
            comentarios: [...state.comentarios, ...r],
          ),
        );
        emit(
          state.copyWith(comentariosState: const ComentariosState.initial()),
        );
      },
    );
  }

  void _onEliminarComentario(
    EliminarComentario event,
    Emitter<HiloState> emit,
  ) {
    emit(
      state.copyWith(
        comentarios: state.comentarios
            .where(
              (element) => element.id != event.id,
            )
            .toList(),
      ),
    );
  }

  FutureOr<void> _onAgregarComentario(
    AgregarComentario event,
    Emitter<HiloState> emit,
  ) {
    emit(state.copyWith(comentarios: [event.comentario, ...state.comentarios]));
  }
}
