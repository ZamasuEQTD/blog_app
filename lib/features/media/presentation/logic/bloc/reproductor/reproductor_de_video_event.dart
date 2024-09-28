part of 'reproductor_de_video_bloc.dart';

sealed class ReproductorDeVideoEvent extends Equatable {
  const ReproductorDeVideoEvent();

  @override
  List<Object?> get props => [];
}

final class InicializarReproductor extends ReproductorDeVideoEvent {
  const InicializarReproductor();
}

class CambiarParametros extends ReproductorDeVideoEvent {
  final EstadoDeReproductor? reproductor;
  final bool? reproduciendo;
  final bool? buffering;
  final bool? pantalla_completa;
  final bool? finalizado;
  final Duration? position;
  final double? volumen;

  const CambiarParametros({
    this.reproductor,
    this.reproduciendo,
    this.buffering,
    this.pantalla_completa,
    this.position,
    this.finalizado,
    this.volumen,
  });
  @override
  List<Object?> get props => [
        reproductor,
        reproduciendo,
        buffering,
        pantalla_completa,
        position,
        volumen
      ];
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
