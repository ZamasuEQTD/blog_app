part of 'crear_encuesta_bloc.dart';

class CrearEncuestaState extends Equatable {
  final List<String> encuesta;
  const CrearEncuestaState({
    this.encuesta = const []
  });
  
  @override
  List<Object> get props => [encuesta];

  CrearEncuestaState copyWith({
    List<String>? encuesta
  }) {
    return CrearEncuestaState(encuesta: encuesta?? this.encuesta);
  }
}

