// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart' hide BlurEffect;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'package:blog_app/src/lib/features/app/presentation/widgets/effects/blur/blur_effect.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/item_seleccionable.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/measured_sized.dart';
import 'package:blog_app/src/lib/features/auth/presentation/logic/controlls/auth_controller.dart';
import 'package:blog_app/src/lib/features/auth/presentation/widgets/sesion_requerida.dart';
import 'package:blog_app/src/lib/features/hilo/domain/services/tag_service.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/screens/hilo/logic/controllers/ver_hilo_controller.dart';
import 'package:blog_app/src/lib/features/media/domain/igallery_service.dart';
import 'package:blog_app/src/lib/features/media/presentation/multi_media.dart';
import 'package:blog_app/src/lib/modules/routing.dart';

import '../../../../../app/presentation/controllers/altura_controller.dart';
import '../../../../../app/presentation/widgets/colored_icon_button.dart';
import '../../../../../app/presentation/widgets/dialogs/bottom_sheet.dart';
import '../../../../../app/presentation/widgets/grupo_seleccionable.dart';
import '../../../../../media/domain/models/media.dart';
import '../../../../../media/presentation/miniatura.dart';

class ComentarHiloBottomSheet extends StatefulWidget {
  const ComentarHiloBottomSheet({super.key});

  @override
  State<ComentarHiloBottomSheet> createState() =>
      _ComentarHiloBottomSheetState();
}

class _ComentarHiloBottomSheetState extends State<ComentarHiloBottomSheet> {
  final TextEditingController comentario = TextEditingController();

  @override
  void initState() {
    final HiloController controller = Get.find();

    comentario.addListener(
      () {
        controller.taggueos = TagService.getTags(comentario.text);
      },
    );

    controller.taggueo.listen(
      (tag) {
        if (tag != null) {
          comentario.text += ">>$tag";
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AlturaController>(
      global: false,
      init: context.read<AlturaController>(),
      builder: (controller) => AlturaNotifier(
        onSizeChange: (size) => controller.altura.value = size.height,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (!Get.find<AuthController>().sesionIniciada) {
              SesionRequeridaBottomSheet.show(context);
            }
          },
          child: Obx(
            () => IgnorePointer(
              ignoring: !Get.find<AuthController>().sesionIniciada,
              child: ColoredBox(
                color: Theme.of(context).colorScheme.surface,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xffe1e1e1))),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => Get.find<HiloController>().media.value != null
                            ? Row(
                                children: <Media>[
                                  Get.find<HiloController>()
                                      .media
                                      .value!
                                      .spoileable,
                                ]
                                    .map(
                                      (x) => GestureDetector(
                                        onTap: () {
                                          _showMediaBottomSheet(context, x);
                                        },
                                        child: Stack(
                                          children: [
                                            Miniatura(
                                              key: UniqueKey(),
                                              media: x,
                                            ),
                                            Positioned.fill(
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: SizedBox.square(
                                                  dimension: 30,
                                                  child: ColoredIconButton(
                                                    onPressed: () => Get.find<
                                                            HiloController>()
                                                        .eliminarMedia(),
                                                    icon: const FittedBox(
                                                      child: Icon(
                                                        CupertinoIcons.xmark,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ).paddingAll(4),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ).marginOnly(bottom: 5)
                            : const SizedBox(),
                      ),
                      Row(
                        children: [
                          ColoredIconButton(
                            onPressed: () => showMaterialModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const ComentarHiloOpcionesItems();
                              },
                            ),
                            icon: const Icon(Icons.three_k_rounded),
                          ),
                          Flexible(
                            child: TextField(
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              decoration: InputDecoration(
                                hintText: "Escribe un comentario...",
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 11,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              controller: comentario,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 4,
                            ).marginSymmetric(horizontal: 5),
                          ),
                          ColoredIconButton(
                            background: const Color.fromRGBO(22, 22, 23, 1),
                            onPressed: () =>
                                Get.find<HiloController>().enviarComentario,
                            icon: const Icon(
                              CupertinoIcons.paperplane_fill,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 5, vertical: 10),
                ),
              ),
            ),
          ),
        ).animate().moveY(
              curve: Curves.easeInOut,
              begin: 300,
              duration: const Duration(milliseconds: 500),
            ),
      ),
    );
  }

  Future<dynamic> _showMediaBottomSheet(BuildContext context, Media x) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => VerMediaBottomSheet(media: x),
    );
  }
}

class ComentarHiloOpcionesItems extends StatelessWidget {
  const ComentarHiloOpcionesItems({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoundedBottomSheet.sliver(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 25,
          ),
          sliver: GrupoSeleccionableSliver(
            seleccionables: [
              OpcionDeComentario.agregarEnlace(),
              OpcionDeComentario.agregarMedia(),
            ],
          ),
        ),
      ],
    );
  }
}

abstract class VerMediaOpcion extends StatelessWidget {
  const VerMediaOpcion._({super.key});

  const factory VerMediaOpcion.spoiler() = _MarcarComoSpoiler;
  const factory VerMediaOpcion.eliminar() = _EliminarMedia;
}

class _MarcarComoSpoiler extends VerMediaOpcion {
  const _MarcarComoSpoiler({super.key}) : super._();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HiloController>();
    return Obx(
      () => ItemSeleccionable.checkbox(
        onChange: (value) {
          controller.media.value = controller.media.value!.copyWith(
            spoiler: value,
          );
        },
        titulo: "Marcar como spoiler",
        value: controller.media.value?.spoiler ?? false,
      ),
    );
  }
}

class _EliminarMedia extends VerMediaOpcion {
  const _EliminarMedia({super.key}) : super._();
  @override
  Widget build(BuildContext context) {
    return ItemSeleccionable.text(
      trailing: ClipOval(
        child: ColoredBox(
          color: Theme.of(context).colorScheme.onSurface,
          child: SizedBox.square(
            dimension: 30,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: FaIcon(
                  FontAwesomeIcons.trash,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Get.find<HiloController>().eliminarMedia();
        context.pop();
      },
      titulo: "Eliminar",
    );
  }
}

abstract class OpcionDeComentario extends StatelessWidget {
  const OpcionDeComentario._({super.key});
  const factory OpcionDeComentario({
    required void Function() onTap,
    required String opcion,
  }) = _OpcionDeComentario;

  const factory OpcionDeComentario.agregarEnlace() = _AgregarEnlace;
  const factory OpcionDeComentario.agregarMedia() = _AgregarMediaItem;
}

class _OpcionDeComentario extends OpcionDeComentario {
  final String opcion;
  final void Function() onTap;

  const _OpcionDeComentario({
    required this.opcion,
    required this.onTap,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return ItemSeleccionable.text(titulo: opcion, onTap: onTap);
  }
}

class _AgregarEnlace extends OpcionDeComentario {
  const _AgregarEnlace() : super._();

  @override
  Widget build(BuildContext context) {
    return OpcionDeComentario(
      onTap: () => context.push(
        Routes.agregarEnlace,
        extra: (String enlace) {
          Get.find<HiloController>().agregarMedia(
            Youtube.fromUrl(enlace),
          );
          context.pop();
        },
      ),
      opcion: "Agregar enlace",
    );
  }
}

class _AgregarMediaItem extends OpcionDeComentario {
  const _AgregarMediaItem({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return OpcionDeComentario(
      onTap: () async {
        IGalleryService service = GetIt.I.get();

        var response = await service.pickFile(extensions: []);

        response.fold((l) => null, (r) {
          if (r != null) {
            Get.find<HiloController>().agregarMedia(r);
          }
        });
      },
      opcion: "Agregar desde galeria",
    );
  }
}

class VerMediaBottomSheet extends StatelessWidget {
  final Media media;
  const VerMediaBottomSheet({
    super.key,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet.sliver(
      slivers: [
        SliverToBoxAdapter(
          child: DimensionableScope(
            builder: (context, dimensionable) => Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 350,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      child: Stack(
                        children: [
                          dimensionable,
                          Obx(
                            () => Positioned.fill(
                              child: BlurEffect(
                                blurear: Get.find<HiloController>()
                                    .media
                                    .value!
                                    .spoiler,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            child: MultiMedia(media: media),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          sliver: GrupoSeleccionableSliver(
            seleccionables: [
              VerMediaOpcion.spoiler(),
              VerMediaOpcion.eliminar(),
            ],
          ),
        ),
      ],
    );
  }
}