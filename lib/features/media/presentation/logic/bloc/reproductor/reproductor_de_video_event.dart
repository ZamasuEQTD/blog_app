part of 'reproductor_de_video_bloc.dart';

sealed class ReproductorDeVideoEvent extends Equatable {
  const ReproductorDeVideoEvent();

  @override
  List<Object> get props => [];
}

final class InicializarReproductor extends ReproductorDeVideoEvent {
  const InicializarReproductor();
}

final class FinalizarVideo extends ReproductorDeVideoEvent {
  const FinalizarVideo();
}

final class BufferearVideo extends ReproductorDeVideoEvent {
  const BufferearVideo();
}

final class PausarVideo extends ReproductorDeVideoEvent {
  const PausarVideo();
}

final class ReproducirVideo extends ReproductorDeVideoEvent {
  const ReproducirVideo();
}

final class EntrarEnPantallaCompleta extends ReproductorDeVideoEvent {
  const EntrarEnPantallaCompleta();
}

final class SalirDePantallaCompleta extends ReproductorDeVideoEvent {
  const SalirDePantallaCompleta();
}

final class ToggleControls extends ReproductorDeVideoEvent {
  const ToggleControls();
}

final class AddListeners extends ReproductorDeVideoEvent {}
