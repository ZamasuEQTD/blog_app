import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';

abstract class IHomePortadasHub {
  Stream<HomePortada> get onHiloPosteado;
  Stream<String> get onHiloEliminado;
  void connect();
  void dispose();
}
