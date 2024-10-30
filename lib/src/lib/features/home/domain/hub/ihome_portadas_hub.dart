import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';

typedef OnHiloCreado = void Function(HomePortada portada);
typedef OnHiloEliminado = void Function(HomePortadaId id);

abstract class IHomePortadasHub {
  void onHiloCreado(OnHiloCreado on);
  void onHiloEliminado(OnHiloEliminado on);
}
