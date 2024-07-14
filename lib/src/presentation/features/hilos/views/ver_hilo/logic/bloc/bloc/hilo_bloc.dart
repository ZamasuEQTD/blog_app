import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'hilo_event.dart';
part 'hilo_state.dart';

class HiloBloc extends Bloc<HiloEvent, HiloState> {
  HiloBloc() : super(HiloInitial()) {
    on<HiloEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
