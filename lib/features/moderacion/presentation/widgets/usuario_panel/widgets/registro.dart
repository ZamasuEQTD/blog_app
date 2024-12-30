import 'package:blog_app/features/app/presentation/logic/extensions/duration_extension.dart';
import 'package:blog_app/features/media/presentation/logic/extension/media_extension.dart';
import 'package:blog_app/features/moderacion/domain/models/registro_usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RegistroItem extends StatelessWidget {
  final Registro registro;
  const RegistroItem({super.key, required this.registro});

  String get titulo =>
      (registro is HiloPosteadoRegistro
          ? "Ha Posteado : "
          : "Ha comentado en : ") +
      registro.hilo.titulo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push("/hilo/${registro.hilo.id}"),
      child: ClipRRect(
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
                      titulo,
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
                "Hace ${registro.fecha.tiempoTranscurrido}",
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
      ).marginOnly(bottom: 10),
    );
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
            const SizedBox(height: 5),
            Bone.text(
              words: 1,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Bone.multiText(
              lines: 2,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ).paddingAll(16),
      ),
    ).marginOnly(bottom: 10);
  }
}
