import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/data/features/home/models/get_home_portadas_request.dart';
import 'package:blog_app/domain/features/categorias/entities/subcategoria.dart';
import 'package:blog_app/domain/features/home/entities/home_portada_de_hilo.dart';
import 'package:blog_app/domain/features/home/usecases/get_home_portadas.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
part 'portadas_home_event.dart';
part 'portadas_home_state.dart';

class PortadasHomeBloc extends Bloc<PortadasHomeEvent, PortadasHomeState> {
  final GetHomePortadasUseCase _useCase;

  PortadasHomeBloc(this._useCase) : super(const PortadasHomeState()) {
    on<CargarPortadasHome>(_onCargarPortadasHome );
    on<CambiarFiltrosDePortadas>(_onCambiarFiltros);
  }

  Future _onCargarPortadasHome(
    CargarPortadasHome event, Emitter<PortadasHomeState> emit
  ) async {

    if (state.status == PortadasHomeStatus.cargando) return;

    emit(state.copyWith(status: PortadasHomeStatus.cargando));

    var result = await _useCase.handle(GetHomePortadasRequest(
      titulo: state.filtros.titulo
    ));

    result.fold(
        (l) => emit(
            state.copyWith(status: PortadasHomeStatus.failure, failure: l)),
        (r) => emit(state.copyWith(
            status: PortadasHomeStatus.initial,
            portadas: [...state.portadas, ...r],
            filtros: r.isNotEmpty? state.filtros.copyWith(ultimoBump: r.last.ultimoBump) : state.filtros
          ) 
          )
        );

    if (emit.isDone) return;
  }

  void _onCambiarFiltros(
    CambiarFiltrosDePortadas event, Emitter<PortadasHomeState> emit) {
    emit(
      state.copyWith(
        portadas: [],
        filtros: state.filtros.copyWith(
        subcategoria: event.subcategoria,
        titulo: event.titulo,
    )));
    add(CargarPortadasHome());
  }
}
