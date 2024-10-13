import 'package:blog_app/features/hilos/domain/models/hilo.dart';
import 'package:blog_app/features/home/domain/abstractions/ihome_hub.dart';
import 'package:blog_app/features/home/domain/models/home_portada_entry.dart';

class LocalHomeHub extends IHomeHub {
  @override
  void onHiloEliminado(void Function(HiloId id) onHiloEliminado) {
    // TODO: implement onHiloEliminado
  }

  @override
  void onHiloPosteado(void Function(PortadaEntity portada) onHiloPosteado) {
    // TODO: implement onHiloPosteado
  }
}
