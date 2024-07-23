part of 'hilo_bloc.dart';

sealed class HiloEvent extends Equatable {
  const HiloEvent();

  @override
  List<Object> get props => [];
}

 
class CargarHilo extends HiloEvent {}

class RecargarHilo extends HiloEvent {}

class EliminarHilo extends HiloEvent {}