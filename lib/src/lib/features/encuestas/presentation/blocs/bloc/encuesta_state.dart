// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'encuesta_bloc.dart';

class EncuestaState extends Equatable {
  final RespuestaId? opcionSeleccionada;
  final Encuesta encuesta;
  const EncuestaState({
    required this.encuesta,
    this.opcionSeleccionada,
  });

  @override
  List<Object?> get props => [opcionSeleccionada];

  EncuestaState copyWith({
    Encuesta? encuesta,
    RespuestaId? opcionSeleccionada,
  }) {
    return EncuestaState(
      encuesta: encuesta ?? this.encuesta,
      opcionSeleccionada: opcionSeleccionada ?? this.opcionSeleccionada,
    );
  }
}
