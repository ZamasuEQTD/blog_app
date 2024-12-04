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
          children: [
            Row(
              children: [
                SizedBox.square(
                  dimension: 48,
                  child: Image(image: registro.hilo.portada.toProvider),
                ),
                Column(
                  children: [
                    Text(registro.hilo.titulo),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                        ),
                        Text(
                          "${registro.fecha.day}-${registro.fecha.month}-${registro.fecha.year}",
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  registro.contenido,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ).paddingAll(16),
      ),
    );
  }
}

class RegistroItemSkeleton extends StatelessWidget {
  const RegistroItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: const ColoredBox(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Bone.square(
                  size: 48,
                ),
                Column(
                  children: [
                    Bone.text(words: 3),
                    Row(
                      children: [
                        Icon(Icons.calendar_month),
                        Bone.text(words: 2),
                      ],
                    ),
                  ],
                ),
                Bone.text(words: 1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
