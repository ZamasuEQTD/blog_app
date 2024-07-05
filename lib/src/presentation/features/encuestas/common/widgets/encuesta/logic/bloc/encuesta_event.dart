part of 'encuesta_bloc.dart';

sealed class EncuestaEvent extends Equatable {
  const EncuestaEvent();

  @override
  List<Object> get props => [];
}

final class AgregarVoto extends EncuestaEvent {

}