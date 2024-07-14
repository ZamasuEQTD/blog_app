import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/src/application/features/home/queries/get_home_portadas_query/get_home_portadas_query.dart';
import 'package:blog_app/src/application/features/home/queries/get_home_portadas_query/get_home_portadas_query_handler.dart';
import 'package:blog_app/src/domain/features/categorias/models/subcategoria.dart';
import 'package:blog_app/src/domain/features/home/models/portada.dart';
import 'package:blog_app/src/shared_kernel/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
part 'portadas_home_event.dart';
part 'portadas_home_state.dart';

class PortadasHomeBloc extends Bloc<PortadasHomeEvent, PortadasHomeState> {
  final GetHomePortadasQueryHandler _handler;

  PortadasHomeBloc(this._handler) : super(const PortadasHomeState()) {
    on<CargarPortadasHome>(_onCargarPortadasHome,transformer: restartable());
    on<CambiarFiltrosDePortadas>(_onCambiarFiltros);
  }

  Future _onCargarPortadasHome(
      CargarPortadasHome event, Emitter<PortadasHomeState> emit) async {
    if (state.status == PortadasHomeStatus.cargando) return;

    emit(state.copyWith(status: PortadasHomeStatus.cargando));

    await Future.delayed(const Duration(seconds: 3));

    var result = await _handler.handle(GetHomePortadasQuery());

    result.fold(
        (l) => emit(
            state.copyWith(status: PortadasHomeStatus.failure, failure: l)),
        (r) => emit(state.copyWith(
            status: PortadasHomeStatus.initial,
            portadas: [...state.portadas, ...r],
            filtros: state.filtros.copyWith(ultimoBump: r.last.ultimoBump))));

    if (emit.isDone) return;
    // We should reach here only for latest event
    print('Finished test count: ${state.portadas.length}, is emitter alive: ${!emit.isDone}');
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
