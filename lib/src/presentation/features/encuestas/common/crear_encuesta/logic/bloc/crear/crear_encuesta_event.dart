part of 'crear_encuesta_bloc.dart';

sealed class CrearEncuestaEvent extends Equatable {
  const CrearEncuestaEvent();

  @override
  List<Object> get props => [];
}

class AgregarOpcion extends CrearEncuestaEvent {}

class EliminarOpcion extends CrearEncuestaEvent {
  final int idx;
  const EliminarOpcion({
    required this.idx
  });
}

class CambiarOpcion extends CrearEncuestaEvent {
  final int idx;
  final String opcion;

  const CambiarOpcion({
    required this.idx, required this.opcion
  });
}
