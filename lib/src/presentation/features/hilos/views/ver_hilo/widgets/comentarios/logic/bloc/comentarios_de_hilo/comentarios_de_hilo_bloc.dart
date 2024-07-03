import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/src/application/features/comentarios/queries/get_comentarios/get_comentarios_query.dart';
import 'package:blog_app/src/application/features/comentarios/queries/get_comentarios/get_comentarios_query_handler.dart';
import 'package:blog_app/src/domain/features/comentarios/models/comentario.dart';
import 'package:blog_app/src/domain/features/hilos/models/types/hilo_id.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'comentarios_de_hilo_event.dart';
part 'comentarios_de_hilo_state.dart';

class ComentariosDeHiloBloc extends Bloc<ComentariosDeHiloEvent, ComentariosDeHiloState> {
  final HiloId hiloId;
  final GetComentariosQueryHandler handler = GetIt.I.get();
  ComentariosDeHiloBloc(this.hiloId) : super(const ComentariosDeHiloState()) {
    on<CargarComentarios >(_onCargarComentarios);
  }

  Future _onCargarComentarios(CargarComentarios  event, Emitter<ComentariosDeHiloState> emit) async{
    if(state.status == ComentariosDeHiloStatus.cargando){
      return;
    }

    emit(state.copyWith(
        status: ComentariosDeHiloStatus.cargando
    ));
    
    var result = await handler.handle(GetComentariosQuery(pagina: state.pagina, id: hiloId));

    result.fold((l) => emit(state.copyWith(
      status: ComentariosDeHiloStatus.failure,
    )),
    (r) => emit(state.copyWith(
      comentarios: r,
      status: ComentariosDeHiloStatus.cargados,
      pagina: state.pagina + 1
    )));

    emit(ComentariosDeHiloState(
      pagina: state.pagina
    ));
  }
}
