import 'package:blog_app/features/app/presentation/logic/extensions/duration_extension.dart';
import 'package:blog_app/features/app/presentation/logic/extensions/scroll_controller_extension.dart';
import 'package:blog_app/features/baneos/presentation/has_sido_baneado_bottomsheet.dart';
import 'package:blog_app/features/media/presentation/logic/extension/media_extension.dart';
import 'package:blog_app/features/notificaciones/domain/models/notificacion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../logic/controles/mis_notificaciones_controller.dart';

class NotificacionesScreen extends StatefulWidget {
  const NotificacionesScreen({super.key});

  @override
  State<NotificacionesScreen> createState() => _NotificacionesScreenState();
}

class _NotificacionesScreenState extends State<NotificacionesScreen> {
  final ScrollController scroll = ScrollController();

  final controller = Get.put(MisNotificacionesController());

  @override
  void initState() {
    controller.cargar();

    scroll.addListener(() {
      if (scroll.isBottom) {
        controller.cargar();
      }
    });

    super.initState();
  }

  int get cantidadDeNotificaciones =>
      controller.notificaciones.value.length + (controller.cargando ? 15 : 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notificaciones"),
      ),
      body: CustomScrollView(
        controller: scroll,
        slivers: [
          SliverList.builder(
            itemCount: cantidadDeNotificaciones,
            itemBuilder: (context, index) {
              if (index >= controller.notificaciones.value.length) {
                return const NotificacionSkeletonItem();
              }

              final notificacion = controller.notificaciones.value[index];

              return NotificacionItem(notificacion: notificacion);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<MisNotificacionesController>();
    scroll.dispose();
    super.dispose();
  }
}

const BorderRadiusGeometry radius = BorderRadius.all(Radius.circular(10));

class NotificacionItem extends StatelessWidget {
  final Notificacion notificacion;

  const NotificacionItem({super.key, required this.notificacion});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius,
      child: ColoredBox(
        color: Colors.white,
        child: GestureDetector(
          onTap: () => context.push("/hilo/${notificacion.hilo.id}"),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: SizedBox.square(
                      dimension: 50,
                      child: Image(image: notificacion.hilo.portada.toProvider),
                    ),
                  ),
                  Text(
                    notificacion.hilo.titulo,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ).marginOnly(left: 10),
                ],
              ),
              Text("hace ${notificacion.fecha.tiempoTranscurrido}"),
              Text(
                notificacion.content,
                maxLines: 4,
              ),
            ],
          ).paddingAll(10),
        ),
      ),
    ).marginOnly(bottom: 10).marginSymmetric(horizontal: 5);
  }

  String get titulo {
    switch (notificacion) {
      case HiloSeguidoComentado():
        return "Hilo seguido comentado";
      case HiloComentado():
        return "Han comentado tu hilo";
      case ComentarioRespondido notificacion:
        return "Han respondido a tu comentario: ${notificacion.respondido}";
      default:
        throw UnimplementedError(
          "No se ha implementado el titulo para $notificacion",
        );
    }
  }
}

class NotificacionSkeletonItem extends StatelessWidget {
  const NotificacionSkeletonItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Skeletonizer(
      child: ClipRRect(
        borderRadius: radius,
        child: Column(
          children: [
            Bone.text(
              words: 2,
            ),
            Row(
              children: [
                Bone.square(size: 50),
                Bone.text(words: 2),
              ],
            ),
            Bone.text(words: 4),
            Bone.text(words: 1),
          ],
        ),
      ),
    );
  }
}
