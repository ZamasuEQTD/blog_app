import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'crear_encuesta_event.dart';
part 'crear_encuesta_state.dart';

class CrearEncuestaBloc extends Bloc<CrearEncuestaEvent, CrearEncuestaState> {
  CrearEncuestaBloc() : super(const CrearEncuestaState()) {
    on<AgregarOpcion>(_onAgregarOpcion);
    on<EliminarOpcion>(_onEliminarOpcion);
    on<CambiarOpcion>(_onCambiarOpcion);
  }

  void _onAgregarOpcion(AgregarOpcion event, Emitter<CrearEncuestaState> emit) {
    emit(state.copyWith(encuesta: [...state.encuesta,""]));
  }


  void _onEliminarOpcion(EliminarOpcion event, Emitter<CrearEncuestaState> emit) {
    state.encuesta.removeAt(event.idx);

    emit(state.copyWith(encuesta:state.encuesta));
  }

  void _onCambiarOpcion(CambiarOpcion event, Emitter<CrearEncuestaState> emit) {
    state.encuesta[event.idx] = event.opcion;
    emit(
      state.copyWith(
        encuesta: state.encuesta
      )
    );
  }
}
