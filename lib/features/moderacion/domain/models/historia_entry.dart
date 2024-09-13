import 'package:blog_app/features/hilos/domain/models/hilo.dart';
import 'package:blog_app/features/media/domain/models/media.dart';

class HiloCreadoHistorialEntry {
  final HiloId hiloId;
  final String titulo;
  final String descripcion;
  final Imagen portada;

  const HiloCreadoHistorialEntry(
      {required this.hiloId,
      required this.titulo,
      required this.descripcion,
      required this.portada});
}

class ComentarioCreadoHistorialEntry {
  final HiloId hiloId;
  final String titulo;
  final Imagen portada;
  final Imagen? imagen;

  ComentarioCreadoHistorialEntry(
      {required this.hiloId,
      required this.titulo,
      required this.portada,
      required this.imagen});
}
