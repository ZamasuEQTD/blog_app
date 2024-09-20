import 'package:blog_app/features/hilos/domain/models/hilo.dart';
import 'package:blog_app/features/home/domain/models/home_portada_entry.dart';

abstract class IHomeHub {
  void onHiloPosteado(void Function(HomePortadaEntity portada) onHiloPosteado);
  void onHiloEliminado(void Function(HiloId id) onHiloEliminado);
}
