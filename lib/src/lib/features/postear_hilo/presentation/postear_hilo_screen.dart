import 'dart:developer';

import 'package:blog_app/src/lib/features/app/presentation/widgets/colored_icon_button.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/effects/blur/blur_effect.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/grupo_seleccionable.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/item_seleccionable.dart';
import 'package:blog_app/src/lib/features/auth/presentation/widgets/sesion_requerida.dart';
import 'package:blog_app/src/lib/features/baneos/presentation/screens/banear_usuario_screen.dart';
import 'package:blog_app/src/lib/features/categorias/presentation/subcategoria_tile.dart';
import 'package:blog_app/src/lib/features/media/domain/igallery_service.dart';
import 'package:blog_app/src/lib/features/media/presentation/extensions/media_extensions.dart';
import 'package:blog_app/src/lib/features/postear_hilo/logic/controllers/postear_hilo_controller.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
        if (failure != null) {
          context.showFlash(
            duration: const Duration(seconds: 3),
            builder: (context, controller) => Provider.value(
              value: controller,
              child: FailureSnackbar(
                failure: failure,
              ),
            ),
          );
        }
      },
    );

    controller.id.listen((id) {
      if (id != null) {
        context.showFlash(
          duration: const Duration(seconds: 3),
          builder: (context, controller) => Provider.value(
            value: controller,
            child: const SuccessSnackbar(
              message: "Hilo creado",
            ),
          ),
        );

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
                  const PostearHiloLabelSection(label: "Subcategoria"),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
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
                  ).paddingSymmetric(horizontal: 25),
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

typedef SnackbarBuilder = Widget Function(BuildContext context, Widget? child);

abstract class Snackbar extends StatelessWidget {
  const Snackbar._({super.key});
}

class _Snackbar extends Snackbar {
  final FlashController controller;
  final SnackbarBuilder builder;
  const _Snackbar({
    super.key,
    required this.controller,
    required this.builder,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return FlashBar(
      content: const Text("data"),
      controller: controller,
      backgroundColor: const Color(0xff2e2e2e),
      position: FlashPosition.top,
      builder: builder,
    );
  }
}

extension BuildContextExtensions on BuildContext {
  ThemeData get actualTheme => Theme.of(this);

  ThemeData get newTheme => Theme.of(this).copyWith(
        checkboxTheme: const CheckboxThemeData(),
        appBarTheme: actualTheme.appBarTheme.copyWith(
          backgroundColor: const Color(0xffF1F1F1),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: actualTheme.elevatedButtonTheme.style?.copyWith(
            foregroundColor: const WidgetStatePropertyAll(Colors.black),
            backgroundColor: const WidgetStatePropertyAll(Colors.white),
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 16),
            ),
            iconColor: const WidgetStatePropertyAll(Colors.black),
            textStyle: const WidgetStatePropertyAll(
              TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        inputDecorationTheme: actualTheme.inputDecorationTheme.copyWith(),
      );
}

abstract class MySnackbar extends StatelessWidget {
  const MySnackbar({super.key});
}

class _MySnackbar extends MySnackbar {
  final Widget child;
  const _MySnackbar({required this.child});

  @override
  Widget build(BuildContext context) {
    return FlashBar(
      controller: context.read(),
      behavior: FlashBehavior.floating,
      backgroundColor: const Color(0xff2e2e2e),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      position: FlashPosition.top,
      content: const SizedBox(),
      builder: (context, _) => child.paddingSymmetric(
        horizontal: 15,
        vertical: 15,
      ),
    );
  }
}

class SuccessSnackbar extends MySnackbar {
  final String message;
  const SuccessSnackbar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return _MySnackbar(
      child: Row(
        children: [
          const ClipOval(
            child: SizedBox.square(
              dimension: 25,
              child: ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: FaIcon(
                      FontAwesomeIcons.check,
                    ),
                  ),
                ),
              ),
            ),
          )
              .animate()
              .scale(
                duration: const Duration(
                  milliseconds: 500,
                ),
                curve: Curves.bounceOut,
              )
              .marginOnly(right: 10),
          const Text(
            "Hilo creado",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class FailureSnackbar extends MySnackbar {
  final Failure failure;
  const FailureSnackbar({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    return _MySnackbar(
      child: Text(
        failure.descripcion ?? failure.code,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
