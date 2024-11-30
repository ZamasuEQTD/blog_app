import 'package:blog_app/src/lib/features/app/presentation/widgets/colored_icon_button.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/grupo_seleccionable.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/item_seleccionable.dart';
import 'package:blog_app/src/lib/features/auth/presentation/widgets/sesion_requerida.dart';
import 'package:blog_app/src/lib/features/categorias/presentation/seleccionar_subcategoria_bottom_sheet.dart';
import 'package:blog_app/src/lib/features/media/domain/igallery_service.dart';
import 'package:blog_app/src/lib/features/media/presentation/extensions/media_extensions.dart';
import 'package:blog_app/src/lib/features/postear_hilo/logic/controllers/postear_hilo_controller.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../app/presentation/widgets/snackbar.dart';
import '../../media/presentation/multi_media.dart';

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
    controller.failure.listen(
      (failure) {
        if (failure != null) {}
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
    return Scaffold(
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
                    onChanged: (value) => controller.titulo.value = value,
                    decoration: const InputDecoration(
                      hintText: "Titulo",
                    ),
                  ).marginOnly(bottom: 24, top: 8),
                  const SizedBox(
                    height: 10,
                  ),
                  const PostearHiloLabelSection(label: "Descripción"),
                  TextField(
                    onChanged: (value) => controller.descripcion.value = value,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: "Descripción",
                    ),
                  ).marginOnly(bottom: 24, top: 8),
                  const PostearHiloLabelSection(label: "Subcategoria"),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GestureDetector(
                      onTap: () => SeleccionarSubcategoriaBottomSheet.show(
                        context,
                        (subcategoria) =>
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
                                          image: controller.subcategoria.value!
                                              .imagen.toProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ).marginOnly(right: 10),
                                    Text(controller.subcategoria.value!.nombre),
                                  ],
                                );
                              },
                            ),
                            const Icon(CupertinoIcons.chevron_right),
                          ],
                        ).paddingSymmetric(horizontal: 10, vertical: 15),
                      ),
                    ),
                  ).marginOnly(bottom: 24, top: 8),
                  const PostearHiloLabelSection(label: "Portada"),
                  Obx(
                    () {
                      if (controller.portada.value == null) {
                        return SizedBox(
                          width: double.infinity,
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
                                  dimensionable,
                                  // Obx(
                                  //   () => Positioned.fill(
                                  //     child: BlurEffect(
                                  //       blurear:
                                  //           controller.portada.value!.esSpoiler,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              );
                            },
                            child: controller.portada.value!.spoileable.widget
                                .marginOnly(bottom: 10),
                          ),
                          GrupoSeleccionable(
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
                  ).marginOnly(bottom: 24, top: 8),
                  const PostearHiloLabelSection(label: "Encuesta"),
                  Obx(() {
                    if (controller.encuesta.value.isEmpty) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => controller.agregarRespuesta(),
                          label: const Text("Agregar encuesta"),
                          icon: const FaIcon(FontAwesomeIcons.chartSimple),
                        ).withSecondaryStyle(context),
                      );
                    }
                    return Column(
                      children: [
                        ...controller.encuesta.value.asMap().entries.map(
                              (e) => TextField(
                                controller: respuestas[e.key],
                                decoration: InputDecoration(
                                  hintText: "Respuesta",
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 1),
                                    child: ColoredIconButton(
                                      onPressed: () {
                                        controller.eliminarRespuesta(e.key);
                                      },
                                      icon: const FittedBox(
                                        child: FaIcon(
                                          FontAwesomeIcons.x,
                                          color: Colors.white,
                                        ),
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
                  GrupoSeleccionable(
                    seleccionables: [
                      ItemSeleccionable.checkbox(
                        onChange: (value) => controller.dados.value = value!,
                        titulo: "Dados",
                        value: controller.dados.value,
                      ),
                      ItemSeleccionable.checkbox(
                        titulo: "Eliminar",
                        onChange: (value) => controller.idunico.value = value!,
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
                  ).paddingSymmetric(horizontal: 25).marginOnly(bottom: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
