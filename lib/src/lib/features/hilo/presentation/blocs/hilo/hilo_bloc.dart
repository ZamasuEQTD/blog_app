import 'package:bloc/bloc.dart';
import 'package:blog_app/src/lib/features/hilo/domain/ihilos_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/models/hilo.dart';

part 'hilo_event.dart';
part 'hilo_state.dart';

class HiloBloc extends Bloc<HiloEvent, HiloState> {
  final String id;
  final IHilosRepository _hilosRepository = GetIt.I.get();

  HiloBloc(this.id) : super(const HiloState()) {
    on<RecargarHilo>(_onRecargarHilo);
    on<CargarHilo>(_onCargarHilo);
    on<EliminarHilo>(_onEliminarHilo);
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
}
