import 'dart:async';

import 'package:blog_app/domain/features/comentarios/entities/comentario.dart';
import 'package:blog_app/domain/features/hilo/abstractions/hilo_hub.dart';

class HiloHub extends IHiloHub {
  final String hiloId;
  HiloHub({required this.hiloId});
  @override
  void onComentado(void Function(Comentario comentario) onComentado) {
    Timer.periodic(
        const Duration(seconds: 10),
        (timer) => onComentado(Comentario(
            id: "id",
            texto: "texto",
            color: ColoresDeComentario.multi,
            createdAt: DateTime.now(),
            datos: const DatosDeComentario(
                tag: "FSAFAS", tagUnico: "fas", dados: "5"),
            autor: const Autor(
                nombre: "Gatubi", rango: "Moderador", rangoCorto: "MOD"))));
  }

  @override
  void onEliminado(void Function() onEliminado) {
    onEliminado();
  }

  @override
  void onComentarioEliminado(
      void Function(ComentarioId id) onComentarioEliminado) {}
}
