import 'dart:ffi';

import 'package:blog_app/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/features/hilos/presentation/screens/hilo_screen/logic/controllers/hilo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../comentarios/presentation/widgets/comentario/hilo_comentario.dart';

class HiloComentarios extends StatefulWidget {
  const HiloComentarios({super.key});

  @override
  State<HiloComentarios> createState() => _HiloComentariosState();
}

class _HiloComentariosState extends State<HiloComentarios> {
  final Map<ComentarioId, GlobalKey> keys = {};

  final HiloController controller = Get.find()..cargarComentarios();

  @override
  void initState() {
    controller.ultimoComentarioAgregado.listen(
      (comentario) {
        if (comentario != null) {
          if (keys.containsKey(comentario.id)) return;

          keys[comentario.id] = GlobalKey();
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: Text(
              "Comentarios ${controller.hilo.value!.comentarios}",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ).marginSymmetric(vertical: 10, horizontal: 5),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 10),
            sliver: SliverList.builder(
              itemCount: controller.comentarios.value.length,
              itemBuilder: (context, index) {
                return HiloComentario(
                  comentario: controller.comentarios.value[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
