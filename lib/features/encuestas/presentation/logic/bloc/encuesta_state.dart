// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'encuesta_bloc.dart';

class EncuestaState extends Equatable {
  final Encuesta encuesta;
  final OpcionDeEncuestaId? opcionSeleccionada;
  const EncuestaState({required this.encuesta, this.opcionSeleccionada});

  @override
  List<Object> get props => [encuesta];

  EncuestaState copyWith({
    Encuesta? encuesta,
    Nullable<OpcionDeEncuestaId>? opcionSeleccionada,
  }) {
    return EncuestaState(
      encuesta: encuesta ?? this.encuesta,
      opcionSeleccionada: opcionSeleccionada != null
          ? opcionSeleccionada.value
          : this.opcionSeleccionada,
    );
  }
}
