import 'package:bloc/bloc.dart';
import 'package:blog_app/features/auth/presentation/logic/validation/username.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'registro_event.dart';
part 'registro_state.dart';

class RegistroBloc extends Bloc<RegistroEvent, RegistroState> {
  RegistroBloc() : super(const RegistroState()) {
    on<RegistroEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
