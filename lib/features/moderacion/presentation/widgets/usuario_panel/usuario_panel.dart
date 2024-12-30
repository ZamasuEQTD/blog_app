import 'package:blog_app/features/app/presentation/logic/extensions/scroll_controller_extension.dart';
import 'package:blog_app/features/moderacion/presentation/widgets/usuario_panel/logic/controllers/registro_de_usuario_controller.dart';
import 'package:blog_app/features/moderacion/presentation/widgets/usuario_panel/widgets/registro.dart';
import 'package:blog_app/features/moderacion/presentation/widgets/usuario_panel/widgets/seleccionar_registro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'widgets/registros.dart';
import 'widgets/usuario_registro.dart';

class UsuarioPanelBottomSheet extends StatelessWidget {
  final String usuario;

  const UsuarioPanelBottomSheet({
    required this.usuario,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 0.7,
      snap: true,
      expand: false,
      snapSizes: const [0.5, 0.7],
      builder: (BuildContext context, ScrollController scrollController) {
        return ChangeNotifierProvider.value(
          value: scrollController,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Provider.value(
              value: usuario,
              child: const UsuarioPanel(),
            ),
          ),
        );
      },
    );
  }

  static void show(BuildContext context, {required String usuario}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => UsuarioPanelBottomSheet(usuario: usuario),
    );
  }
}

class UsuarioPanel extends StatefulWidget {
  const UsuarioPanel({super.key});

  @override
  State<UsuarioPanel> createState() => _UsuarioPanelState();
}

class _UsuarioPanelState extends State<UsuarioPanel> {
  late final controller = Get.put(
    RegistroDeUsuarioController(
      id: context.read(),
    ),
  );

  late final ScrollController scroll = context.read();

  @override
  void initState() {
    controller.cargarUsuario();

    controller.usuario.listen((usuario) {
      if (usuario != null) {
        controller.cargarRegistros();
      }
    });

    controller.status.listen(
      (status) {
        if (status == RegistroDeUsuarioStatus.cargando) {
          controller.cargarRegistros();
        }
      },
    );

    controller.registro.listen((registro) {
      controller.cargarRegistros();
    });

    scroll.addListener(() {
      if (scroll.isBottom) {
        controller.cargarRegistros();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScrollView(
        controller: scroll,
        slivers: [
          if (!controller.isUsuarioCargado)
            const UsuarioPanelSkeleton()
          else
            Provider.value(
              value: controller.usuario.value!,
              child: SliverMainAxisGroup(
                slivers: [
                  const UsuarioRegistro(),
                  const SeleccionarRegistro(),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 10),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    sliver: Obx(
                      () {
                        if (controller.registro.value ==
                            RegistroSeleccionado.hilo) {
                          return const RegistrosHilos();
                        }
                        if (controller.registro.value ==
                            RegistroSeleccionado.comentario) {
                          return const RegistrosComentarios();
                        }
                        return const SliverToBoxAdapter();
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ).paddingSymmetric(vertical: 10),
    );
  }
}

class UsuarioPanelSkeleton extends StatelessWidget {
  const UsuarioPanelSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer.sliver(
      child: SliverMainAxisGroup(
        slivers: [
          const UsuarioRegistroSkeleton(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            sliver: SliverList.builder(
              itemCount: 10,
              itemBuilder: (context, index) => const RegistroItemSkeleton(),
            ),
          ),
        ],
      ),
    );
  }
}
