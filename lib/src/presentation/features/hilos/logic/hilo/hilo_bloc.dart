import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/src/application/features/comentarios/queries/get_comentarios/get_comentarios_query.dart';
import 'package:blog_app/src/application/features/comentarios/queries/get_comentarios/get_comentarios_query_handler.dart';
import 'package:blog_app/src/application/features/hilos/queries/get_hilo/get_hilo_query.dart';
import 'package:blog_app/src/application/features/hilos/queries/get_hilo/get_hilo_query_handler.dart';
import 'package:blog_app/src/domain/features/comentarios/models/comentario.dart';
import 'package:blog_app/src/domain/features/hilos/models/hilo.dart';
import 'package:blog_app/src/domain/features/media/models/media.dart';
import 'package:blog_app/src/domain/shared/models/spoileable.dart';
import 'package:equatable/equatable.dart';

part 'hilo_event.dart';
part 'hilo_state.dart';

class HiloBloc extends Bloc<HiloEvent, HiloState> {
  final GetHiloQueryHandler handler;
  HiloBloc(this.handler) : super(const HiloState()) {
    on<RecargarHilo>(_onRecargarHilo);
    on<CargarHilo>(_onCargarHilo);
  }

  void _onRecargarHilo(RecargarHilo event, Emitter<HiloState> emit) {
    emit(const HiloState());
    add(CargarHilo());
  }



  Future _onCargarHilo(CargarHilo event, Emitter<HiloState> emit)async {
    emit(state.copyWith(
      status: HiloStatus.cargando
    ));

    var result = await handler.handle(GetHiloQuery(""));

    result.fold(
      (l) => emit(state.copyWith(status: HiloStatus.initial)), 
      (r) => emit(state.copyWith(hilo: r,status: HiloStatus.cargado),)
    );
  }
}
