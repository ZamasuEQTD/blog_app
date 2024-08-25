part of 'encuesta_bloc.dart';

sealed class EncuestaEvent extends Equatable {
  const EncuestaEvent();

  @override
  List<Object> get props => [];
}

class AgregarVoto extends EncuestaEvent {
  final OpcionDeEncuestaId id;

  const AgregarVoto({required this.id});
}

class SeleccionarOpcion extends EncuestaEvent {
  final OpcionDeEncuestaId id;

  const SeleccionarOpcion({required this.id});
}

class Votar extends EncuestaEvent {
  const Votar();
}
