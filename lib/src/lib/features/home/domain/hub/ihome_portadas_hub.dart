import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';

abstract class IPortadasHub {
  Stream<Portada> get onHiloPosteado;
  Stream<String> get onHiloEliminado;
  void connect();
  void dispose();
}
