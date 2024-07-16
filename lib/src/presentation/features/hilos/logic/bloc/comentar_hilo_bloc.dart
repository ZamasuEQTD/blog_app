import 'package:bloc/bloc.dart';
import 'package:blog_app/src/domain/shared/models/spoileable.dart';
import 'package:equatable/equatable.dart';

import '../../../../../domain/features/media/models/media.dart';

part 'comentar_hilo_event.dart';
part 'comentar_hilo_state.dart';

class ComentarHiloBloc extends Bloc<ComentarHiloEvent, ComentarHiloState> {
  ComentarHiloBloc() : super(ComentarHiloState()) {
    on<ComentarHiloEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
