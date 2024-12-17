// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/features/app/domain/models/spoileable.dart';
import 'package:blog_app/features/app/presentation/logic/controller/altura_controller.dart';
import 'package:blog_app/features/app/presentation/theme/app_colors.dart';
import 'package:blog_app/features/app/presentation/widgets/altura_notifier.dart';
import 'package:blog_app/features/app/presentation/widgets/colored_icon_button.dart';
import 'package:blog_app/features/app/presentation/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/features/app/presentation/widgets/effects/blur/blur_effect.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/grupo_seleccionable.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/item_seleccionable.dart';
import 'package:blog_app/features/app/presentation/widgets/snackbars/snackbar.dart';
import 'package:blog_app/features/auth/presentation/logic/controllers/auth_controller.dart';
import 'package:blog_app/features/auth/presentation/widgets/bottom_sheet/sesion_requerida.dart';
import 'package:blog_app/features/comentarios/presentation/utils/tags_service.dart';
import 'package:blog_app/features/hilos/presentation/screens/hilo_screen/logic/controllers/hilo_controller.dart';
import 'package:blog_app/features/media/domain/abstractions/igallery_service.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:blog_app/features/media/presentation/widgets/miniatura/miniatura.dart';
import 'package:blog_app/features/media/presentation/widgets/multi_media.dart';
import 'package:blog_app/modules/routing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart' hide BlurEffect;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ComentarHilo extends StatefulWidget {
  const ComentarHilo({super.key});

  @override
  State<ComentarHilo> createState() => _ComentarHiloState();
}

class _ComentarHiloState extends State<ComentarHilo> {
  final TextEditingController comentario = TextEditingController();

  @override
  void initState() {
    final HiloController controller = Get.find();

    controller.comentarHiloStatus.listen((state) {
      if (state == ComentarHiloStatus.enviado) {
        Snackbars.showSuccess(context, "Comentario enviado");

        comentario.clear();
      }
    });

    comentario.addListener(
      () {
        controller.tags = TagService.getTags(comentario.text).toList();
      },
    );

    controller.ultimoTagueo.listen(
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
                color: Colors.white,
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
                                                        .media
                                                        .value = null,
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
                            background: AppColors.tertiary,
                            onPressed: () => showMaterialModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const ComentarHiloOpcionesItems();
                              },
                            ),
                            icon: const Icon(
                              Icons.three_k_rounded,
                              color: AppColors.onTertiary,
                            ),
                          ),
                          Flexible(
                            child: TextField(
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              decoration: InputDecoration(
                                fillColor: AppColors.tertiary,
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
                            onPressed: () => Get.find<HiloController>()
                                .enviarComentario(comentario.text),
                            icon: Obx(
                              () => Get.find<HiloController>()
                                          .comentarHiloStatus
                                          .value ==
                                      ComentarHiloStatus.enviando
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ).paddingAll(4)
                                  : const Icon(
                                      CupertinoIcons.paperplane_fill,
                                      color: Colors.white,
                                    ),
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
          sliver: GrupoItemSeleccionable.sliver(
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
        Get.find<HiloController>().media.value = null;
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
          Get.find<HiloController>().media.value = Spoileable(
            false,
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
            Get.find<HiloController>().media.value = Spoileable(false, r);
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
            child: media.widget,
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          sliver: GrupoItemSeleccionable.sliver(
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
