import 'package:blog_app/features/app/domain/models/spoileable.dart';
import 'package:blog_app/features/app/presentation/theme/styles/button_styles.dart';
import 'package:blog_app/features/app/presentation/widgets/colored_icon_button.dart';
import 'package:blog_app/features/app/presentation/widgets/effects/blur/blur_effect.dart';
import 'package:blog_app/features/app/presentation/widgets/pop.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/grupo_seleccionable.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/item_seleccionable.dart';
import 'package:blog_app/features/app/presentation/widgets/snackbars/snackbar.dart';
import 'package:blog_app/features/baneos/domain/failures/estas_baneado_failure.dart';
import 'package:blog_app/features/baneos/presentation/has_sido_baneado_bottomsheet.dart';
import 'package:blog_app/features/categorias/presentation/seleccionar_subcategoria_bottom_sheet.dart';
import 'package:blog_app/features/media/domain/abstractions/igallery_service.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:blog_app/features/media/presentation/logic/extension/media_extension.dart';
import 'package:blog_app/features/media/presentation/widgets/multi_media.dart';
import 'package:blog_app/features/postear_hilo/logic/controllers/postear_hilo_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../app/clases/failure.dart';

class PostearHiloScreen extends StatefulWidget {
  const PostearHiloScreen({super.key});

  @override
  State<PostearHiloScreen> createState() => _PostearHiloScreenState();
}

class _PostearHiloScreenState extends State<PostearHiloScreen> {
  final PostearHiloController controller = PostearHiloController();

  final Map<int, TextEditingController> respuestas = {};

  @override
  void initState() {
    controller.status.listen(
      (status) {
        if (status != PostearHiloStatus.failure) return;

        Failure? failure = controller.failure.value;

        if (failure == null) return;

        if (failure is EstasBaneadoFailure) {
          HasSidoBaneadoBottomsheet.show(context, baneo: failure.baneo);
        } else {
          Snackbars.showFailure(context, failure);
        }
      },
    );

    controller.id.listen((id) {
      if (id != null) {
        context.replace("/hilo/$id");
      }
    });

    controller.respuestaEliminada.listen((idx) {
      if (idx != null) {
        respuestas.remove(idx);
      }
    });

    controller.encuesta.listen((value) {
      for (var i = 0; i < value.length; i++) {
        if (!respuestas.containsKey(i)) {
          respuestas[i] = TextEditingController();
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: !controller.posteando,
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                leading: const BackButton(
                  color: Colors.black,
                ),
                title: const Text(
                  "Postear hilo",
                ),
              ),
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const PostearHiloLabelSection(label: "Titulo"),
                          TextField(
                            onChanged: (value) =>
                                controller.titulo.value = value,
                            decoration: const InputDecoration(
                              hintText: "Titulo",
                            ),
                          ).marginOnly(bottom: 24, top: 8),
                          const SizedBox(
                            height: 10,
                          ),
                          const PostearHiloLabelSection(label: "Descripción"),
                          TextField(
                            onChanged: (value) =>
                                controller.descripcion.value = value,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText: "Descripción",
                            ),
                          ).marginOnly(bottom: 24, top: 8),
                          const PostearHiloLabelSection(label: "Subcategoria"),
                          _seleccionarSubcategoria(context),
                          const PostearHiloLabelSection(label: "Portada"),
                          _portada(context),
                          const PostearHiloLabelSection(label: "Encuesta"),
                          Obx(() {
                            if (controller.encuesta.value.isEmpty) {
                              return SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () =>
                                      controller.agregarRespuesta(),
                                  label: const Text("Agregar encuesta"),
                                  icon: const FaIcon(
                                    FontAwesomeIcons.chartSimple,
                                  ),
                                ).withSecondaryStyle(context),
                              );
                            }
                            return Column(
                              children: [
                                ...controller.encuesta.value
                                    .asMap()
                                    .entries
                                    .map(
                                      (e) => TextField(
                                        controller: respuestas[e.key],
                                        decoration: InputDecoration(
                                          hintText: "Respuesta",
                                          suffixIcon: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 1),
                                            child: IconButton(
                                              onPressed: () {
                                                controller
                                                    .eliminarRespuesta(e.key);
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ).marginOnly(bottom: 5),
                                    ),
                                if (controller.encuesta.value.length < 4)
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: controller.agregarRespuesta,
                                      child: const Text("Agregar respuesta"),
                                    ).withSecondaryStyle(context),
                                  ).marginOnly(top: 5),
                              ],
                            );
                          }).marginOnly(bottom: 24, top: 8),
                          const PostearHiloLabelSection(label: "Opciones"),
                          GrupoItemSeleccionable(
                            seleccionables: [
                              ItemSeleccionable.checkbox(
                                onChange: (value) =>
                                    controller.dados.value = value!,
                                titulo: "Dados",
                                value: controller.dados.value,
                              ),
                              ItemSeleccionable.checkbox(
                                titulo: "Id unico",
                                onChange: (value) =>
                                    controller.idunico.value = value!,
                                value: controller.idunico.value,
                              ),
                            ],
                          ).marginOnly(bottom: 24, top: 8),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => controller.postear(),
                              child: const Text("Postear hilo"),
                            ),
                          )
                              .paddingSymmetric(horizontal: 25)
                              .marginOnly(bottom: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (controller.posteando) const PopLayout(),
          ],
        ),
      ),
    );
  }

  Widget _portada(BuildContext context) {
    return Obx(
      () {
        if (controller.portada.value == null) {
          return Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    IGalleryService service = GetIt.I.get();

                    var response = await service.pickFile(
                      extensions: [],
                    );

                    response.fold(
                      (l) {},
                      (r) {
                        if (r != null) {
                          controller.agregarPortada(r);
                        }
                      },
                    );
                  },
                  label: const Text(
                    "Agregar portada ",
                  ),
                  icon: const FaIcon(
                    FontAwesomeIcons.image,
                  ),
                ).withSecondaryStyle(context),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AgregarEnlaceDialog(
                          onEnlaceAgregado: (enlace) {
                            controller.agregarPortada(Youtube.fromUrl(enlace));
                          },
                        );
                      },
                    );
                  },
                  label: const Text(
                    "Agregar enlace",
                  ),
                  icon: const FaIcon(
                    FontAwesomeIcons.link,
                  ),
                ).withSecondaryStyle(context),
              ),
            ],
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DimensionableScope(
              borderRadius: BorderRadius.circular(20),
              builder: (context, dimensionable) {
                return Stack(
                  children: [
                    Obx(
                      () => Stack(
                        children: [
                          dimensionable,
                          Positioned.fill(
                            child: BlurEffect(
                              blurear: controller.portada.value!.esSpoiler,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              child: controller.portada.value!.spoileable.widget
                  .marginOnly(bottom: 10),
            ),
            GrupoItemSeleccionable(
              seleccionables: [
                ItemSeleccionable.checkbox(
                  onChange: (value) => controller.censurar(),
                  titulo: "Censurar",
                  value: controller.portada.value!.esSpoiler,
                ),
                ItemSeleccionable.destructible(
                  titulo: "Eliminar portada",
                  onTap: () => controller.portada.value = null,
                ),
              ],
            ),
          ],
        );
      },
    ).marginOnly(bottom: 24, top: 8);
  }

  Widget _seleccionarSubcategoria(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () => SeleccionarSubcategoriaBottomSheet.show(
          context,
          onSubcategoriaSeleccionada: (subcategoria) =>
              controller.subcategoria.value = subcategoria,
        ),
        child: ColoredBox(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () {
                  if (controller.subcategoria.value == null) {
                    return const Text(
                      "Selecciona una subcategoria",
                    );
                  }
                  return Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: SizedBox.square(
                          dimension: 25,
                          child: Image(
                            image: controller
                                .subcategoria.value!.imagen.toProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ).marginOnly(right: 10),
                      Text(
                        controller.subcategoria.value!.nombre,
                      ),
                    ],
                  );
                },
              ),
              const Icon(CupertinoIcons.chevron_right),
            ],
          ).paddingSymmetric(
            horizontal: 10,
            vertical: 15,
          ),
        ),
      ),
    ).marginOnly(bottom: 24, top: 8);
  }
}

class PostearHiloLabelSection extends StatelessWidget {
  final String label;
  const PostearHiloLabelSection({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Color.fromRGBO(73, 80, 87, 1),
      ),
    );
  }
}

typedef OnEnlaceAgregado = void Function(String enlace);

class AgregarEnlaceDialog extends StatefulWidget {
  final OnEnlaceAgregado onEnlaceAgregado;
  const AgregarEnlaceDialog({super.key, required this.onEnlaceAgregado});

  @override
  State<AgregarEnlaceDialog> createState() => _AgregarEnlaceDialogState();
}

class _AgregarEnlaceDialogState extends State<AgregarEnlaceDialog> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Agregar enlace",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w800),
          ).marginOnly(bottom: 5),
          TextField(
            minLines: 4,
            maxLines: 4,
            controller: controller,
            decoration: const InputDecoration(hintText: "Enlace"),
          ).marginOnly(bottom: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => widget.onEnlaceAgregado(controller.text),
              child: const Text("Agregar enlace"),
            ),
          ).paddingSymmetric(horizontal: 10),
        ],
      ).paddingAll(20),
    );
  }
}
