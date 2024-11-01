// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/src/lib/features/app/domain/models/spoileable.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/effects/blur/blur_effect.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/grupo_seleccionable.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/item_seleccionable.dart';
import 'package:blog_app/src/lib/features/media/domain/igallery_service.dart';
import 'package:blog_app/src/lib/features/postear_hilo/logic/controllers/postear_hilo_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'package:blog_app/src/lib/features/postear_hilo/presentation/blocs/postear_hilo/postear_hilo_bloc.dart';

import '../../media/presentation/logic/blocs/gestor_de_media/gestor_de_media_bloc.dart';
import '../../media/presentation/multi_media.dart';

class PostearHiloScreen extends StatefulWidget {
  const PostearHiloScreen({super.key});

  @override
  State<PostearHiloScreen> createState() => _PostearHiloScreenState();
}

class _PostearHiloScreenState extends State<PostearHiloScreen> {
  final PostearHiloController controller = PostearHiloController();
  @override
  Widget build(BuildContext context) {
    ThemeData actualTheme = Theme.of(context);
    return Theme(
      data: actualTheme.copyWith(
        appBarTheme: actualTheme.appBarTheme.copyWith(
          backgroundColor: Theme.of(context).colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: actualTheme.colorScheme.onSurface,
        inputDecorationTheme: Theme.of(context)
            .inputDecorationTheme
            .copyWith(fillColor: actualTheme.colorScheme.surface),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const BackButton(
            color: Colors.black,
          ),
          title: const Text(
            "Postear hilo",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => controller.postear,
              child: const Text(
                "Postear",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
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
                    const TextField(
                      decoration: InputDecoration(
                        hintText: "Titulo",
                      ),
                    ).marginOnly(bottom: 24, top: 8),
                    const SizedBox(
                      height: 10,
                    ),
                    const PostearHiloLabelSection(label: "Descripción"),
                    const TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Descripción",
                      ),
                    ).marginOnly(bottom: 24, top: 8),
                    const PostearHiloLabelSection(label: "Portada"),
                    Obx(
                      () {
                        if (controller.portada.value != null) {
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
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
                              child: const Text("Agregar portada "),
                            ),
                          );
                        }

                        return GetBuilder(
                          key: UniqueKey(),
                          init: BlurController()..blurear.value = false,
                          builder: (blur) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DimensionableScope(
                                borderRadius: BorderRadius.circular(20),
                                builder: (context, dimensionable) {
                                  return Stack(
                                    children: [
                                      dimensionable,
                                      Positioned.fill(
                                        child: BlurEffect(
                                          blurear: blur.blurear.value,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                child: controller
                                    .portada.value!.spoileable.widget
                                    .marginOnly(bottom: 10),
                              ),
                              GrupoSeleccionable(
                                seleccionables: [
                                  ItemSeleccionable.checkbox(
                                    onChange: (value) {
                                      controller.portada.value = controller
                                          .portada.value!
                                          .copyWith(spoiler: value!);
                                    },
                                    titulo: "Censurar",
                                    value: controller.portada.value!.esSpoiler,
                                  ),
                                  ItemSeleccionable.destructible(
                                    titulo: "Eliminar portada",
                                    onTap: () =>
                                        controller.portada.value = null,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ).marginOnly(bottom: 24, top: 8),
                    GrupoSeleccionable(
                      seleccionables: [
                        ItemSeleccionable.checkbox(
                          onChange: (value) => controller.dados.value = value!,
                          titulo: "Dados",
                          value: controller.dados.value,
                        ),
                        ItemSeleccionable.checkbox(
                          titulo: "Eliminar",
                          onChange: (value) =>
                              controller.idunico.value = value!,
                          value: controller.idunico.value,
                        ),
                      ],
                    ).marginOnly(bottom: 24, top: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
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
