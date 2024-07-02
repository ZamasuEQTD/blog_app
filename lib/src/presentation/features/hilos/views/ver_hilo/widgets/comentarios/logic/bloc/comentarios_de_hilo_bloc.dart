import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:blog_app/src/domain/features/comentarios/models/types/comentario_id.dart';
import 'package:blog_app/src/shared_kernel/failure.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../../../../domain/features/comentarios/models/comentario.dart';

part 'comentarios_de_hilo_event.dart';
part 'comentarios_de_hilo_state.dart';

class ComentariosDeHiloBloc extends Bloc<ComentariosDeHiloEvent, ComentariosDeHiloState> {
  ComentariosDeHiloBloc() : super(const ComentariosDeHiloState()) {
    on<EliminarComentario>(_onEliminarComentario);
    on<AgregarComentario>(_onAgregarComentario);
    on<CargarComentarios>(_onCargarComentarios);
  }

  void _onEliminarComentario(EliminarComentario event, Emitter<ComentariosDeHiloState> emit) {
    emit(state.copyWith(
      comentarios: state.comentarios.where((c) => c.id != event.id).toList()
    ));
  }



  void _onAgregarComentario(AgregarComentario event, Emitter<ComentariosDeHiloState> emit) {
    emit(state.copyWith(
      comentarios: [event.comentario, ...state.comentarios]
    ));
  }

  Future _onCargarComentarios(CargarComentarios event, Emitter<ComentariosDeHiloState> emit) async {
    emit(state.copyWith(status: ComentariosDeHiloStatus.cargando));
    
    await Future.delayed(const Duration(seconds: 3));
  
    emit(state.copyWith(
      comentarios: [
        ...state.comentarios,
        ...[
          
        ]
      ],
      status: ComentariosDeHiloStatus.initial,
      pagina: state.pagina + 1
    ));
  }

  Comentario _get() {
    return Comentario(
          id: Random().nextInt(1000000).toString(),
          texto: "La mamamamam", 
          createdAt: DateTime(1999), 
          datos: const DatosDeComentario(tag: "AFAFASF", tagUnico: "132", dados: "2"), 
          media: null, 
        );
  }
}
