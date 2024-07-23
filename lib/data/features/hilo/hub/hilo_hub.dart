import 'dart:async';

import 'package:blog_app/domain/features/comentarios/entities/comentario.dart';
import 'package:blog_app/domain/features/hilo/abstractions/hilo_hub.dart';

class HiloHub extends IHiloHub {
  final String hiloId;
  HiloHub({required this.hiloId});
  @override
  void onComentado(void Function(Comentario comentario) onComentado) {
    Timer.periodic(Duration(seconds: 1), (timer) => onComentado(Comentario(id: "id", texto: "texto", color: ColoresDeComentario.multi, createdAt: DateTime.now(), datos: DatosDeComentario(tag: "FSAFAS", tagUnico:null, dados: null), autor:Autor(nombre: "Gatubi", rango: "Moderador", rangoCorto: "MOD"))));
  }

  @override
  void onEliminado(void Function() onEliminado) {
    onEliminado();
  }
  
  @override
  void onComentarioEliminado(void Function(ComentarioId id) onComentarioEliminado) {
  }
  
}