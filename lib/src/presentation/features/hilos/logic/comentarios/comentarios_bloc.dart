import 'package:bloc/bloc.dart';
import 'package:blog_app/src/domain/features/comentarios/models/comentario.dart';
import 'package:blog_app/src/domain/features/media/models/media.dart';
import 'package:blog_app/src/domain/shared/models/spoileable.dart';
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
