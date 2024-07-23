import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/domain/features/hilo/entities/hilo.dart';
import 'package:blog_app/domain/features/hilo/usecases/get_hilo_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data/features/hilo/models/get_hilo_request.dart';

part 'hilo_event.dart';
part 'hilo_state.dart';

class HiloBloc extends Bloc<HiloEvent, HiloState> {
  final GetHiloUseCase handler;
  HiloBloc(this.handler) : super(const HiloState()) {
    on<RecargarHilo>(_onRecargarHilo);
    on<CargarHilo>(_onCargarHilo);
    on<EliminarHilo>(_onEliminarHilo);
  }

  void _onRecargarHilo(RecargarHilo event, Emitter<HiloState> emit) {
    emit(const HiloState());
    add(CargarHilo());
  }



  Future _onCargarHilo(CargarHilo event, Emitter<HiloState> emit)async {
    emit(state.copyWith(
      status: HiloStatus.cargando
    ));

    var result = await handler.handle(GetHiloRequest(id: ""));

    result.fold(
      (l) => emit(state.copyWith(status: HiloStatus.initial)), 
      (r) => emit(state.copyWith(hilo: r,status: HiloStatus.cargado),)
    );
  }

  void _onEliminarHilo(EliminarHilo event, Emitter<HiloState> emit) {
    emit(state.copyWith(
      hilo: state.hilo!.copyWith(estado: EstadoDeHilo.eliminado)
    ));
  }
}
