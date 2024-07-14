part of 'hilo_bloc.dart';

sealed class HiloState extends Equatable {
  const HiloState();
  
  @override
  List<Object> get props => [];
}

final class HiloInitial extends HiloState {}


enum HiloStatus {
  cargando,
}