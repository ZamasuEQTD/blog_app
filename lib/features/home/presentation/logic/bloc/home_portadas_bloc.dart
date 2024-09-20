import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/features/hilos/domain/models/hilo.dart';
import 'package:equatable/equatable.dart';

import '../../../../categorias/domain/models/subcategoria.dart';
import '../../../../../core/classes/failure.dart';
import '../../../domain/abstractions/ihome_repository.dart';
import '../../../domain/models/home_portada_entry.dart';
import '../../../domain/usecases/get_home_portadas.dart';
part 'home_portadas_event.dart';
part 'home_portadas_state.dart';

class HomePortadasBloc extends Bloc<HomePortadasEvent, HomePortadasState> {
  final GetHomePortadasUseCase _getHomePortadasUseCase;

  HomePortadasBloc(this._getHomePortadasUseCase)
      : super(const HomePortadasState()) {
    on<CargarPortadasHome>(_onCargarPortadasHome);
    on<RecargarHomePortadas>(_onRecargarPortadas);
    on<AgregarPortada>(_onAgregarPortada);
    on<EliminarPortada>(_onEliminarPortada);
  }

  Future<void> _onCargarPortadasHome(
      CargarPortadasHome event, Emitter<HomePortadasState> emit) async {
    if (state.status == PortadasHomeStatus.cargando) return;

    List<HomePortadaEntity> entries = state.portadas;

    var result = await _getHomePortadasUseCase
        .handle(GetHomePortadasRequest(titulo: state.filtros.titulo));

    result.fold(
      (l) =>
          emit(state.copyWith(status: PortadasHomeStatus.failure, failure: l)),
      (r) => emit(state.copyWith(
          status: PortadasHomeStatus.initial, portadas: [...entries, ...r])),
    );
  }

  _onRecargarPortadas(
      RecargarHomePortadas event, Emitter<HomePortadasState> emit) {
    emit(const HomePortadasState());
    add(CargarPortadasHome());
  }

  FutureOr<void> _onAgregarPortada(
      AgregarPortada event, Emitter<HomePortadasState> emit) {
    emit(
      state.copyWith(portadas: [...state.portadas, event.portada]),
    );
  }

  FutureOr<void> _onEliminarPortada(
      EliminarPortada event, Emitter<HomePortadasState> emit) {
    emit(
      state.copyWith(
        portadas: state.portadas.where((element) => true).toList(),
      ),
    );
  }
}
