import 'package:bloc/bloc.dart';
import 'package:blog_app/features/moderacion/domain/models/vista_de_usuario.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/models/historia_entry.dart';

part 'ver_usuario_event.dart';
part 'ver_usuario_state.dart';

class VerUsuarioBloc extends Bloc<VerUsuarioEvent, VerUsuarioState> {
  final String usuario;
  VerUsuarioBloc(this.usuario) : super(VerUsuarioInitial()) {
    on<VerUsuarioEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
