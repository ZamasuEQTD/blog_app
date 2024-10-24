part of 'encuesta_bloc.dart';

sealed class EncuestaEvent extends Equatable {
  const EncuestaEvent();

  @override
  List<Object> get props => [];
}

class SeleccionarRespuesta extends EncuestaEvent {
  final RespuestaId id;

  const SeleccionarRespuesta({required this.id});
}

class SumarVoto extends EncuestaEvent {
  final RespuestaId id;

  const SumarVoto({required this.id});
}
