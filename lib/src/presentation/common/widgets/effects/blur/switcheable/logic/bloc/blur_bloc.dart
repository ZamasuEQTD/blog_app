import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'blur_event.dart';
part 'blur_state.dart';

class BlurBloc extends Bloc<BlurEvent, BlurState> {
  final bool initial;
  BlurBloc({
    this.initial = false
  }) : super( initial? Blureable() : NoBlureable() ) {
    on<SwitchBlur>(_onSwitch);
  }

  FutureOr<void> _onSwitch(SwitchBlur event, Emitter<BlurState> emit) {
     if(state is Blureable) {
      emit(NoBlureable());
     } else {
      emit(Blureable());
     }
  }
}
