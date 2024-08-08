class Hilo {
  final HiloId id;
  final String titulo;
  final String descripcion;
  final List<BanderasDeHilo> banderas;

  const Hilo(
      {required this.id,
      required this.titulo,
      required this.descripcion,
      required this.banderas});
}

typedef HiloId = String;

enum BanderasDeHilo { dados, sticky, encuesta }
