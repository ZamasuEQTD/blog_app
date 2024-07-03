import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/src/application/features/hilos/queries/get_hilo/get_hilo_query.dart';
import 'package:blog_app/src/application/features/hilos/queries/get_hilo/get_hilo_query_handler.dart';
import 'package:blog_app/src/domain/features/hilos/models/hilo.dart';
import 'package:blog_app/src/shared_kernel/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'ver_hilo_event.dart';
part 'ver_hilo_state.dart';

class VerHiloBloc extends Bloc<VerHiloEvent, VerHiloState> {
  final GetHiloQueryHandler handler = GetIt.I.get();
  VerHiloBloc() : super(VerHiloInitial()) {
    on<CargarHilo>(_onCargarHilo);
  }

  Future _onCargarHilo(CargarHilo event, Emitter<VerHiloState> emit) async {
    emit(CargandoHilo());

    final result = await  handler.handle(GetHiloQuery(""));
  
    result.fold(
      (l) => emit(HiloFailure(failure: l)),
      (r) => emit(HiloCargado(hilo: r))
    );
  }
}
