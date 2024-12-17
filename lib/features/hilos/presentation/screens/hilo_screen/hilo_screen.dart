import 'package:blog_app/features/app/presentation/logic/controller/altura_controller.dart';
import 'package:blog_app/features/app/presentation/logic/extensions/scroll_controller_extension.dart';
import 'package:blog_app/features/app/presentation/widgets/snackbars/snackbar.dart';
import 'package:blog_app/features/baneos/domain/failures/estas_baneado_failure.dart';
import 'package:blog_app/features/baneos/presentation/has_sido_baneado_bottomsheet.dart';
import 'package:blog_app/features/hilos/domain/models/hilo.dart';
import 'package:blog_app/features/hilos/presentation/screens/hilo_screen/logic/controllers/hilo_controller.dart';
import 'package:blog_app/features/hilos/presentation/screens/hilo_screen/widgets/hilo_banderas.dart';
import 'package:blog_app/features/media/presentation/logic/extension/media_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../app/presentation/widgets/effects/blur/contenido_censurable.dart';
import '../../../../categorias/domain/models/categoria.dart';
import '../../../../encuestas/presentation/encuesta.dart';
import '../../../../media/presentation/widgets/multi_media.dart';
import 'widgets/comentar_hilo.dart';
import 'widgets/hilo_acciones.dart';
import 'widgets/hilo_comentarios.dart';
import 'widgets/styles/titulo_style.dart';

class HiloScreen extends StatefulWidget {
  final String id;
  const HiloScreen({super.key, required this.id});

  @override
  State<HiloScreen> createState() => _HiloScreenState();
}

class _HiloScreenState extends State<HiloScreen> {
  final ScrollController scroll = ScrollController();
  late final HiloController controller = Get.put(
    HiloController(id: widget.id),
  )..cargarHilo();

  final AlturaController alturaController = AlturaController();

  @override
  void initState() {
    scroll.addListener(
      () {
        if (scroll.isBottom) {
          controller.cargarComentarios();
        }
      },
    );

    controller.failure.listen((failure) {
      if (failure != null) {
        if (failure is EstasBaneadoFailure) {
          HasSidoBaneadoBottomsheet.show(context, baneo: failure.baneo);
        }
        Snackbars.showFailure(context, failure);

        controller.failure.value = null;
      }
    });

    alturaController.altura.listen((altura) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: Obx(
        () {
          if (controller.hilo.value != null) {
            return ListenableProvider.value(
              value: alturaController,
              child: const ComentarHilo(),
            );
          }
          return const SizedBox();
        },
      ),
      body: Obx(
        () => !(controller.hilo.value == null)
            ? Provider.value(
                value: controller.hilo.value,
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: alturaController.altura.value,
                  ),
                  child: CustomScrollView(
                    controller: scroll,
                    slivers: const [
                      //HiloScreenAppBar(),
                      InformacionDeHilo(),
                      HiloComentarios(),
                    ],
                  ),
                ),
              )
            : Container(),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<HiloController>();
    super.dispose();
  }
}

class InformacionDeHilo extends StatelessWidget {
  const InformacionDeHilo({super.key});

  @override
  Widget build(BuildContext context) {
    final Hilo hilo = context.read();

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
          color: Color(0xffF1F1F1),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HiloBanderas(),
                SubcategoriaDeHiloTile(subcategoria: hilo.categoria),
                const HiloAcciones(),
                if (hilo.encuesta != null)
                  EncuestaWidget(
                    encuesta: hilo.encuesta!,
                  ),
                Center(
                  child: DimensionableScope(
                    constraints: const BoxConstraints(
                      maxHeight: 500,
                      maxWidth: double.infinity,
                    ),
                    builder: (context, dimensionable) {
                      Widget child = dimensionable;

                      if (hilo.portada.esSpoiler) {
                        child = ContenidoCensurable(child: dimensionable);
                      }

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: child,
                      );
                    },
                    child: hilo.portada.spoileable.widget,
                  ),
                ),
                Text(
                  hilo.titulo,
                  style: const TituloStyle(),
                ),
                Text(
                  hilo.descripcion,
                  style: const TextStyle(fontSize: 18),
                ),
              ]
                  .map(
                    (w) => Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: w,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class HiloScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HiloScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(Get.find<HiloController>().hilo.value!.titulo),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SubcategoriaDeHiloTile extends StatelessWidget {
  final Subcategoria subcategoria;
  const SubcategoriaDeHiloTile({super.key, required this.subcategoria});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 10,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox.square(
                  dimension: 30,
                  child: Image(image: subcategoria.imagen.toProvider),
                ),
              ),
              const SizedBox(width: 10),
              Text(subcategoria.nombre),
            ],
          ),
        ),
      ),
    );
  }
}

class HiloScreenCargando extends StatelessWidget {
  const HiloScreenCargando({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(7),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
              color: Color(0xffF1F1F1),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ColoredBox(
                          color: Colors.white,
                          child: Row(
                            children: [
                              const BackButton(),
                              ...List.generate(
                                3,
                                (index) => const Bone.square(size: 16)
                                    .marginSymmetric(horizontal: 3),
                              ),
                            ],
                          ).paddingSymmetric(horizontal: 15, vertical: 10),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ColoredBox(
                          color: Colors.white,
                          child: const Row(
                            children: [
                              Bone.square(size: 35),
                              SizedBox(width: 10),
                              Bone.text(
                                words: 2,
                              ),
                            ],
                          ).paddingSymmetric(horizontal: 15, vertical: 10),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ColoredBox(
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: List.generate(
                                  4,
                                  (index) => const Bone.square(size: 16)
                                      .marginSymmetric(horizontal: 3),
                                ),
                              ),
                              const Bone.text(words: 2),
                            ],
                          ).paddingSymmetric(horizontal: 15, vertical: 10),
                        ),
                      ),
                    ].map((w) => w.marginOnly(bottom: 5)),
                    const Center(
                      child: Bone.square(
                        size: 150,
                      ),
                    ),
                    const Bone.multiText(
                      lines: 2,
                      style: TituloStyle(),
                    ),
                    const Bone.multiText(
                      lines: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Bone.text(
          words: 3,
          fontSize: 20,
        ),
      ],
    );
  }
}
