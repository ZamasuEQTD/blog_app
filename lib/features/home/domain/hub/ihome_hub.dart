import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:blog_app/features/hilos/domain/models/types.dart';

abstract class IHomeHub {
  Stream<PortadaHilo> get onHiloPosteado;
  Stream<HiloId> get onHiloEliminado;
  void connect();
  void dispose();
}
