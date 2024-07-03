part of 'ver_hilo_bloc.dart';

sealed class VerHiloState extends Equatable {
  const VerHiloState();
  
  @override
  List<Object> get props => [];
}

final class VerHiloInitial extends VerHiloState {}

final class CargandoHilo extends VerHiloState {}

final class HiloCargado extends VerHiloState {
  final Hilo hilo;

  const HiloCargado({
    required this.hilo
  });
}

final class HiloFailure extends VerHiloState {
  final Failure failure;

  const HiloFailure({required this.failure});
}