import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../hilo/domain/ihilos_repository.dart';
import '../../../../../domain/models/home_portada.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IHilosRepository repository = GetIt.I.get();
  HomeBloc() : super(const HomeState()) {
    on<CargarPortadas>(_onCargarPortadas);
  }

  FutureOr<void> _onCargarPortadas(
    CargarPortadas event,
    Emitter<HomeState> emit,
  ) async {
    if (state.portadasState is CargandoHomePortadasState) {
      return;
    }
    emit(
      state.copyWith(
        portadasState: const CargandoHomePortadasState(),
      ),
    );

    var response = await repository.getPortadas();

    response.fold(
      (l) => null,
      (r) {
        emit(
          state.copyWith(
            ultimoBump: r.last.ultimoBump,
            portadas: [...state.portadas, ...r],
            portadasState: CargadasHomePortadasState(portadas: r),
          ),
        );

        emit(state.copyWith(portadasState: const InitialHomePortadasState()));
      },
    );
  }
}
