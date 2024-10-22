import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../utils/clases/failure.dart';

part 'registro_event.dart';
part 'registro_state.dart';

class RegistroBloc extends Bloc<RegistroEvent, RegistroState> {
  RegistroBloc() : super(const RegistroState()) {
    on<RegistroEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
