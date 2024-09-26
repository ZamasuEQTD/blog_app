// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reproductor_de_video_bloc.dart';

class ReproductorDeVideoState extends Equatable {
  final EstadoDeReproductor reproductor;
  final EstadoDeReproduccion reproduccion;
  final EstadoDeBuffer buffer;
  final EstadoDePantalla pantalla;
  final EstadoDeControles controles;
  final Duration position;
  final double volumen;
  const ReproductorDeVideoState({
    this.reproductor = EstadoDeReproductor.inicial,
    this.reproduccion = EstadoDeReproduccion.pausado,
    this.buffer = EstadoDeBuffer.cargado,
    this.pantalla = EstadoDePantalla.normal,
    this.controles = EstadoDeControles.ocultos,
    this.position = Duration.zero,
    this.volumen = -1,
  });

  @override
  List<Object> get props => [reproductor, reproduccion, volumen];

  ReproductorDeVideoState copyWith({
    EstadoDeReproductor? reproductor,
    EstadoDeReproduccion? reproduccion,
    EstadoDeBuffer? buffer,
    EstadoDePantalla? pantalla,
    EstadoDeControles? controles,
    Duration? position,
    double? volumen,
  }) {
    return ReproductorDeVideoState(
      reproductor: reproductor ?? this.reproductor,
      reproduccion: reproduccion ?? this.reproduccion,
      buffer: buffer ?? this.buffer,
      pantalla: pantalla ?? this.pantalla,
      controles: controles ?? this.controles,
      position: position ?? this.position,
      volumen: volumen ?? this.volumen,
    );
  }
}

class EstadoDePantalla extends Equatable {
  final String value;

  const EstadoDePantalla._(this.value);

  static const EstadoDePantalla completa = EstadoDePantalla._("completa");
  static const EstadoDePantalla normal = EstadoDePantalla._("normal");

  @override
  List<Object?> get props => [value];
}

class EstadoDeReproduccion extends Equatable {
  final String value;

  const EstadoDeReproduccion._(this.value);

  static const EstadoDeReproduccion reproduciendo =
      EstadoDeReproduccion._("reproduciendo");

  static const EstadoDeReproduccion pausado = EstadoDeReproduccion._("pausado");

  static const EstadoDeReproduccion finalizado =
      EstadoDeReproduccion._("finalizado");

  @override
  List<Object?> get props => [value];
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

class EstadoDeBuffer extends Equatable {
  final String value;

  const EstadoDeBuffer._(this.value);

  static const EstadoDeBuffer cargando = EstadoDeBuffer._("cargando");
  static const EstadoDeBuffer cargado = EstadoDeBuffer._("cargado");

  @override
  List<Object?> get props => [value];
}

class EstadoDeControles extends Equatable {
  final String value;

  const EstadoDeControles._(this.value);

  static const EstadoDeControles mostrar = EstadoDeControles._("mostrar");
  static const EstadoDeControles ocultos = EstadoDeControles._("ocultos");

  @override
  List<Object?> get props => [value];
}
