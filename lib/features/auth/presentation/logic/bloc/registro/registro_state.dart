part of 'registro_bloc.dart';

sealed class RegistroState extends Equatable {
  const RegistroState();
  
  @override
  List<Object> get props => [];
}

final class RegistroInitial extends RegistroState {}
