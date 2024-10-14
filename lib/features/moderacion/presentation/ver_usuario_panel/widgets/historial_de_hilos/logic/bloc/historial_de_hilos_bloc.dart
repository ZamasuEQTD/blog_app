import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'historial_de_hilos_event.dart';
part 'historial_de_hilos_state.dart';

class HistorialDeHilosBloc extends Bloc<HistorialDeHilosEvent, HistorialDeHilosState> {
  HistorialDeHilosBloc() : super(HistorialDeHilosInitial()) {
    on<HistorialDeHilosEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
