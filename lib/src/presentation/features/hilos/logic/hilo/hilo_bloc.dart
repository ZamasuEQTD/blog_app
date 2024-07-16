import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/src/application/features/comentarios/queries/get_comentarios/get_comentarios_query.dart';
import 'package:blog_app/src/application/features/comentarios/queries/get_comentarios/get_comentarios_query_handler.dart';
import 'package:blog_app/src/domain/features/comentarios/models/comentario.dart';
import 'package:blog_app/src/domain/features/hilos/models/hilo.dart';
import 'package:blog_app/src/domain/features/media/models/media.dart';
import 'package:blog_app/src/domain/shared/models/spoileable.dart';
import 'package:equatable/equatable.dart';

part 'hilo_event.dart';
part 'hilo_state.dart';

class HiloBloc extends Bloc<HiloEvent, HiloState> {
   HiloBloc() : super(const HiloState()) {
    on<RecargarHilo>(_onRecargarHilo);
  }

  void _onRecargarHilo(RecargarHilo event, Emitter<HiloState> emit) {
    emit(const HiloState());
    add(CargarHilo());
  }


}
