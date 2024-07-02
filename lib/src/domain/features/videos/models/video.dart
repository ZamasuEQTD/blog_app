import 'dart:async';

abstract class ReproductorVideoState {
  const ReproductorVideoState();  
}
class ReproductorDeVideoSinInicializar {
  
}

abstract class Reproductor {
  final StreamController<EstadoDeReproduccion> reproduccionStream = StreamController.broadcast();
  final StreamController<EstadoDeSonido> sonidoStream = StreamController.broadcast();

  final Duration duracion;

  Duration posicion;

  EstadoDeReproduccion reproduccion;
  EstadoDeSonido sonido;

  bool get reproduciendo => reproduccion is Reproduciendo; 
  bool get pausado => reproduccion is Pausado; 

  Reproductor({
    required this.duracion,
    this.sonido = const SonidoInhabilitado(),
    this.reproduccion = const Pausado(),
    this.posicion = Duration.zero
  });

  void reproducir(){
    if(reproduciendo){
      throw Exception("Ya está reproduciendo");
    }
    reproduccion = Reproduciendo();
    reproduccionStream.add(reproduccion);
  }

  void pausar(){
    if(pausado){
      throw Exception("Ya está pausado");
    }
    reproduccion = const Pausado();
    reproduccionStream.add(reproduccion);
  }

  void seekTo(Duration momento){
    if(momento >= duracion){
      posicion = duracion;
      reproduccion = Finalizado();
      reproduccionStream.add(reproduccion);
    } else if(momento <= Duration.zero){
      posicion = Duration.zero;
    } else {
      posicion = momento;
    }
  }

  void cambiarVolumen(double volumen){
    if(sonido is SonidoHabilitado){
      sonido = (sonido as SonidoHabilitado).copyWith(volumen: volumen);
      sonidoStream.add(sonido);
    } else {
      throw Exception("No tiene sonido disponible");
    }
  }

  void mutear(){
    cambiarVolumen(0);
  }
}

class ReproductorDeVideo extends Reproductor {
  final StreamController<EstadoDePantalla> pantallaStream = StreamController();

  EstadoDePantalla pantalla;  

  ReproductorDeVideo({
    this.pantalla = const PantallaNormal(),
    required super.duracion,
    super.posicion,
    super.reproduccion,
    super.sonido
  });

  void entrarPantallaCompleta(){
    if(pantalla is PantallaCompleta){
      throw Exception("Ya esta en pantalla completa");
    }
    pantalla = const PantallaCompleta();
    pantallaStream.add(pantalla);
  }

  void salirPantallaCompleta(){
    if(pantalla is PantallaNormal){
      throw Exception("Ya esta en pantalla normal");
    }
    pantalla = const PantallaNormal();
  }
}

abstract class EstadoDePantalla {
  const EstadoDePantalla();
}

class PantallaCompleta extends EstadoDePantalla{
  const PantallaCompleta();
}

class PantallaNormal extends EstadoDePantalla{
  const PantallaNormal();
}

abstract class EstadoDeReproduccion {
  const EstadoDeReproduccion();
}

class Buffereando extends EstadoDeReproduccion {}

class Pausado extends EstadoDeReproduccion{
  const Pausado();
}

class Finalizado extends EstadoDeReproduccion{}

class Reproduciendo extends EstadoDeReproduccion{}

abstract class EstadoDeSonido {
  const EstadoDeSonido();
}

class SonidoInhabilitado extends EstadoDeSonido{
  const SonidoInhabilitado();
}

class SonidoHabilitado extends EstadoDeSonido{
  static const double max = 1;
  static const double min = 0;

  final double volumen;

  const SonidoHabilitado(this.volumen):assert(!(volumen > max || volumen < min), "El volumen debe estar entre $min y $max");

  SonidoHabilitado copyWith({
    double? volumen
  }){
    return SonidoHabilitado(volumen?? this.volumen);
  }
}
