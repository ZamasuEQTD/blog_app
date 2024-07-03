part of 'ver_hilo_bloc.dart';

sealed class VerHiloEvent extends Equatable {
  const VerHiloEvent();

  @override
  List<Object> get props => [];
}
final class CargarHilo extends VerHiloEvent {}  