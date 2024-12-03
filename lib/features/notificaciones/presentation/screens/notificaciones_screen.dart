// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:blog_app/features/app/presentation/logic/extensions/scroll_controller_extension.dart';
import 'package:blog_app/features/media/presentation/logic/extension/media_extension.dart';
import 'package:blog_app/features/moderacion/domain/models/registro_de_hilo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:blog_app/features/moderacion/domain/models/registro_de_comentario.dart';
import 'package:blog_app/features/notificaciones/presentation/logic/controles/mis_notificaciones_controller.dart';

import '../../domain/models/notificacion.dart';

class NotificacionesScreen extends StatefulWidget {
  const NotificacionesScreen({super.key});

  @override
  State<NotificacionesScreen> createState() => _NotificacionesScreenState();
}

class _NotificacionesScreenState extends State<NotificacionesScreen> {
  final ScrollController scroll = ScrollController();

  final MisNotificacionesController controller = Get.put(
    MisNotificacionesController(),
  )..cargar();

  @override
  void initState() {
    scroll.addListener(() {
      if (scroll.IsBottom) controller.cargar();
    });

    super.initState();
  }

  @override
  void dispose() {
    scroll.dispose();
    Get.delete<MisNotificacionesController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "Mis notificaciones",
        ),
        actions: [
          TextButton(
            onPressed: controller.leerTodas,
            child: const Text("Leer todas"),
          ),
        ],
      ),
      body: CustomScrollView(
        controller: scroll,
        slivers: [
          Obx(
            () => SliverList.builder(
              itemCount: controller.notificaciones.value.length,
              itemBuilder: (context, index) => SocialInteraction.notificacion(
                notificacion: controller.notificaciones.value[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

abstract class SocialInteraction extends StatelessWidget {
  const SocialInteraction._({super.key});

  const factory SocialInteraction({
    ImageProvider<Object>? imagen,
    List<Widget>? actions,
    required String descripcion,
    required String subtitulo,
    required String titulo,
  }) = _SocialInteraction;

  const factory SocialInteraction.notificacion({
    Key? key,
    required Notificacion notificacion,
  }) = _NotificacionSocialInteraction;

  const factory SocialInteraction.historial({required Historial historial}) =
      _HistorialSocialInteraction;

  const factory SocialInteraction.bone() = _BoneSocialInteraction;
}

class _SocialInteraction extends SocialInteraction {
  final ImageProvider? imagen;

  final String titulo;
  final String subtitulo;
  final String descripcion;

  final List<Widget>? actions;
  const _SocialInteraction({
    required this.titulo,
    required this.subtitulo,
    required this.descripcion,
    this.imagen,
    this.actions,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.onSurface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imagen != null)
                  SocialInteractionImage.image(provider: imagen!),
                const SizedBox(
                  width: 5,
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        maxLines: 2,
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          text: titulo,
                          children: [
                            TextSpan(
                              text: subtitulo,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        descripcion,
                        maxLines: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (actions != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!,
              ),
          ],
        ),
      ),
    );
  }
}

class _BoneSocialInteraction extends SocialInteraction {
  static final Random random = Random();

  const _BoneSocialInteraction({super.key}) : super._();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SocialInteractionImage.bone(),
        const SizedBox(
          width: 5,
        ),
        Column(
          children: [
            Bone.text(
              width: random.nextInt(250).toDouble(),
            ),
            const SizedBox(
              height: 10,
            ),
            Bone.text(
              width: random.nextInt(250).toDouble(),
            ),
          ],
        ),
      ],
    );
  }
}

class _NotificacionSocialInteraction extends SocialInteraction {
  final Notificacion notificacion;

  const _NotificacionSocialInteraction({super.key, required this.notificacion})
      : super._();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                minimumSize: const WidgetStatePropertyAll(Size(100, 0)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
        ),
      ),
      child: SocialInteraction(
        titulo: titulo,
        subtitulo: notificacion.titulo,
        descripcion: descripcion,
        imagen: notificacion.portada.toProvider,
        actions: [
          SizedBox(
            width: 100,
            child: ElevatedButton(
              onPressed: () => context.push("/hilo/${notificacion.hiloId}"),
              child: const Text("Ir a hilo"),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () =>
                Get.find<MisNotificacionesController>().leer(notificacion.id),
            child: const Text("Leer"),
          ),
        ],
      ),
    );
  }

  String get descripcion => notificacion is HiloComentado
      ? (notificacion as HiloComentado).descripcion
      : (notificacion as ComentarioRespondido).comentario;

  String get titulo => notificacion is HiloComentado
      ? "Han comentado el hilo: "
      : "Te han respondido en:";
}

class _HistorialSocialInteraction extends SocialInteraction {
  final Historial historial;
  const _HistorialSocialInteraction({
    required this.historial,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return SocialInteraction(
      imagen: historial.portada.toProvider,
      descripcion: descripcion,
      subtitulo: historial.titulo,
      titulo: titulo,
    );
  }

  String get titulo =>
      historial is HiloHistorial ? "Ha posteado" : "Ha comentado";

  String get descripcion => historial is HiloHistorial
      ? (historial as HiloHistorial).descripcion
      : (historial as ComentarioHistorial).texto;
}

abstract class SocialInteractionImage extends StatelessWidget {
  const SocialInteractionImage._({super.key});

  const factory SocialInteractionImage({required Widget imagen, Key? key}) =
      _SocialInteractionImage;

  const factory SocialInteractionImage.image({
    Key? key,
    required ImageProvider<Object> provider,
  }) = _SocialInteractionProvider;

  const factory SocialInteractionImage.bone() = _SocialInteractionBone;
}

class _SocialInteractionImage extends SocialInteractionImage {
  final Widget imagen;

  const _SocialInteractionImage({super.key, required this.imagen}) : super._();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 80,
        width: 80,
        child: imagen,
      ),
    );
  }
}

class _SocialInteractionBone extends SocialInteractionImage {
  const _SocialInteractionBone({
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return const SocialInteractionImage(imagen: Bone());
  }
}

class _SocialInteractionProvider extends SocialInteractionImage {
  final ImageProvider provider;

  const _SocialInteractionProvider({super.key, required this.provider})
      : super._();
  @override
  Widget build(BuildContext context) {
    return SocialInteractionImage(
      imagen: Image(
        image: provider,
        fit: BoxFit.cover,
      ),
    );
  }
}
