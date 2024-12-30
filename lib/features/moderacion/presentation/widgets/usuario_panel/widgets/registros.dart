import 'package:blog_app/features/app/presentation/logic/extensions/duration_extension.dart';
import 'package:blog_app/features/baneos/presentation/has_sido_baneado_bottomsheet.dart';
import 'package:blog_app/features/home/presentation/screens/home_screen.dart';
import 'package:blog_app/features/media/presentation/logic/extension/media_extension.dart';
import 'package:blog_app/features/moderacion/domain/models/registro_usuario.dart';
import 'package:blog_app/features/moderacion/presentation/widgets/usuario_panel/logic/controllers/registro_de_usuario_controller.dart';
import 'package:blog_app/features/moderacion/presentation/widgets/usuario_panel/widgets/registro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RegistrosHilos extends StatelessWidget {
  const RegistrosHilos({super.key});

  @override
  Widget build(BuildContext context) {
    RegistroDeUsuarioController controller = Get.find();
    return Obx(
      () => SliverList.builder(
        itemCount: controller.hilos.value.length +
            (controller.isHilosCargados ? 20 : 0),
        itemBuilder: (context, index) {
          if (index > controller.hilos.value.length) {
            return const RegistroItemSkeleton();
          }

          return RegistroItem(registro: controller.hilos.value[index]);
        },
      ),
    );
  }
}

class RegistrosComentarios extends StatelessWidget {
  const RegistrosComentarios({super.key});

  @override
  Widget build(BuildContext context) {
    RegistroDeUsuarioController controller = Get.find();
    return Obx(
      () => SliverList.builder(
        itemCount: controller.comentarios.value.length +
            (controller.isComentariosCargados ? 20 : 0),
        itemBuilder: (context, index) {
          if (index > controller.comentarios.value.length) {
            return const RegistroItemSkeleton();
          }

          return RegistroItem(registro: controller.comentarios.value[index]);
        },
      ),
    );
  }
}
