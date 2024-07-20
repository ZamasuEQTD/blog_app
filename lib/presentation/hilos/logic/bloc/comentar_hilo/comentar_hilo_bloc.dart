import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'comentar_hilo_event.dart';
part 'comentar_hilo_state.dart';

class ComentarHiloBloc extends Bloc<ComentarHiloEvent, ComentarHiloState> {
  ComentarHiloBloc() : super(ComentarHiloState()) {
    on<ComentarHiloEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
