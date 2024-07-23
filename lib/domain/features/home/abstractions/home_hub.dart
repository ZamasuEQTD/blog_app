import 'package:blog_app/domain/features/hilo/entities/hilo.dart';
import 'package:blog_app/domain/features/home/entities/home_portada_de_hilo.dart';

abstract class IHomeHub {
  void onHiloPosteado(void Function(HomePortadaDeHilo portada) onHiloPosteado);
  void onHiloEliminado(void Function(HiloId id) onHiloEliminado);
}