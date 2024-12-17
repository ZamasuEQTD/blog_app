import 'package:blog_app/features/media/presentation/logic/extension/media_extension.dart';
import 'package:blog_app/features/moderacion/domain/models/registro_usuario.dart';
import 'package:blog_app/features/moderacion/presentation/widgets/usuario_panel/logic/controllers/registro_de_usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class RegistroItem extends StatelessWidget {
  final Registro registro;
  const RegistroItem({super.key, required this.registro});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox.square(
                    dimension: 70,
                    child: Image(
                      image: registro.hilo.portada.toProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    registro.hilo.titulo,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ).marginOnly(left: 10),
                ),
              ],
            ),
            Text(
              "hace 1h",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              registro.contenido,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ).paddingAll(16),
      ),
    ).marginOnly(bottom: 10);
  }
}

class RegistroItemSkeleton extends StatelessWidget {
  const RegistroItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const Bone.square(
                    size: 70,
                  ),
                ),
                Flexible(
                  child: const Bone.multiText(
                    lines: 2,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ).marginOnly(left: 10),
                ),
              ],
            ),
            Bone.text(
              words: 3,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Bone.multiText(
              lines: 2,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
