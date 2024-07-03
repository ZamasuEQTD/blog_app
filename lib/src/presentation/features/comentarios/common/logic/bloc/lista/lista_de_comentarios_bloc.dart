import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/src/domain/features/comentarios/models/comentario.dart';
import 'package:blog_app/src/domain/features/comentarios/models/types/comentario_id.dart';
import 'package:equatable/equatable.dart';

part 'lista_de_comentarios_event.dart';
part 'lista_de_comentarios_state.dart';

class ListaDeComentariosBloc extends Bloc<ListaDeComentariosEvent, List<Comentario>> {
  ListaDeComentariosBloc() : super(const []) {
    on<AgregarComentarioAlInicio>(_onAgregarAlInicio);
    on<AgregarComentarios>(_onAgregar);
    on<EliminarComentario>(_onEliminar);
  }

  void _onAgregarAlInicio(AgregarComentarioAlInicio event, Emitter<List<Comentario>> emit) {
    emit([event.comentario,...state]);
  }

  void _onAgregar(AgregarComentarios event, Emitter<List<Comentario>> emit) {
    emit([...state,...event.comentarios]);
  }

  void _onEliminar(EliminarComentario event, Emitter<List<Comentario>> emit) {
    emit(state.where((element) => event.id != element.id).toList());
  }
}
