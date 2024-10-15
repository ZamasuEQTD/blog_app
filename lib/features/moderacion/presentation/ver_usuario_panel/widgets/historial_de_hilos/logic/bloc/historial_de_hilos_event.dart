part of 'historial_de_hilos_bloc.dart';

sealed class HistorialDeHilosEvent extends Equatable {
  const HistorialDeHilosEvent();

  @override
  List<Object> get props => [];
}

class CargarSiguientePagina extends HistorialDeHilosEvent {}
