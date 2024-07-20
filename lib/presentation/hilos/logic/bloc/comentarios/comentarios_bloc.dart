import 'package:bloc/bloc.dart';
import 'package:blog_app/domain/features/comentarios/entities/comentario.dart';
import 'package:equatable/equatable.dart';

part 'comentarios_event.dart';
part 'comentarios_state.dart';

class ComentariosBloc extends Bloc<ComentariosEvent, ComentariosState> {
  ComentariosBloc() : super(const ComentariosState()) {
    on<ComentariosEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
