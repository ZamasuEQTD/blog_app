import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blog_app/src/application/features/home/queries/get_home_portadas_query/get_home_portadas_query.dart';
import 'package:blog_app/src/application/features/home/queries/get_home_portadas_query/get_home_portadas_query_handler.dart';
import 'package:blog_app/src/domain/features/categorias/models/types/subcategoria_id.dart';
import 'package:blog_app/src/domain/features/hilos/models/portada_de_hilo.dart';
import 'package:blog_app/src/domain/features/hilos/models/types/hilo_id.dart';
import 'package:blog_app/src/shared_kernel/failure.dart';
import 'package:equatable/equatable.dart';

part 'portadas_home_event.dart';
part 'portadas_home_state.dart';

class PortadasHomeBloc extends Bloc<PortadasHomeEvent, PortadasHomeState> {
  final GetHomePortadasQueryHandler handler;
  PortadasHomeBloc(this.handler) : super(const PortadasHomeState()) {
    on<CargarPortadas>(_cargarPortadas);
  }

  Future _cargarPortadas(CargarPortadas event, Emitter<PortadasHomeState> emit) async {
    emit(state.copyWith(
      status: PortadasHomeStatus.cargando
    ));
    var result = await handler.handle(GetHomePortadasQuery());

    result.fold((l) => emit(state.copyWith(
      status: PortadasHomeStatus.fallido,
      failure: l
    )),
    (r) => emit(state.copyWith(
      status:PortadasHomeStatus.cargados,
      portadas: [...state.portadas,...r]
    )));
  }
}
