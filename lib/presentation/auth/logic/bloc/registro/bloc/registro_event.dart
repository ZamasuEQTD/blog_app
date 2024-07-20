part of 'registro_bloc.dart';

sealed class RegistroEvent extends Equatable {
  const RegistroEvent();

  @override
  List<Object> get props => [];
}

class Registrarse extends RegistroEvent {}