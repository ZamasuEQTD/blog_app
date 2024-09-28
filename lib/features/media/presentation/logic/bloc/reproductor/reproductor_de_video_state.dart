// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reproductor_de_video_bloc.dart';

class ReproductorDeVideoState extends Equatable {
  final EstadoDeReproductor reproductor;
  final bool reproduciendo;
  final bool buffering;
  final bool pantalla_completa;
  final bool mostrar_controles;
  final Duration position;
  final double volumen;

  bool get pausado => !reproduciendo;

  const ReproductorDeVideoState({
    this.reproductor = EstadoDeReproductor.inicial,
    this.reproduciendo = false,
    this.buffering = false,
    this.pantalla_completa = false,
    this.mostrar_controles = false,
    this.position = Duration.zero,
    this.volumen = -1,
  });

  @override
  List<Object> get props => [
        reproductor,
        reproduciendo,
        buffering,
        pantalla_completa,
        mostrar_controles,
        position,
        volumen,
      ];

  ReproductorDeVideoState copyWith({
    EstadoDeReproductor? reproductor,
    bool? reproduciendo,
    bool? buffering,
    bool? pantalla_completa,
    bool? mostrar_controles,
    Duration? position,
    double? volumen,
  }) {
    return ReproductorDeVideoState(
      reproductor: reproductor ?? this.reproductor,
      reproduciendo: reproduciendo ?? this.reproduciendo,
      buffering: buffering ?? this.buffering,
      pantalla_completa: pantalla_completa ?? this.pantalla_completa,
      mostrar_controles: mostrar_controles ?? this.mostrar_controles,
      position: position ?? this.position,
      volumen: volumen ?? this.volumen,
    );
  }
}

class EstadoDeReproductor extends Equatable {
  final String value;

  const EstadoDeReproductor._(this.value);

  static const EstadoDeReproductor inicial = EstadoDeReproductor._("inicial");
  static const EstadoDeReproductor iniciado = EstadoDeReproductor._("iniciado");
  static const EstadoDeReproductor iniciando =
      EstadoDeReproductor._("iniciando");
  static const EstadoDeReproductor fallido = EstadoDeReproductor._("fallido");

  @override
  List<Object?> get props => [value];
}
