import 'package:blog_app/features/app/presentation/logic/extensions/scroll_controller_extension.dart';
import 'package:blog_app/features/moderacion/presentation/widgets/usuario_panel/logic/controllers/registro_de_usuario_controller.dart';
import 'package:blog_app/features/moderacion/presentation/widgets/usuario_panel/widgets/seleccionar_registro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'widgets/registros.dart';
import 'widgets/usuario_registro.dart';

class UsuarioPanelBottomSheet extends StatelessWidget {
  const UsuarioPanelBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        DraggableScrollableSheet(
          initialChildSize: 0.5,
          maxChildSize: 0.7,
          snap: true,
          snapSizes: const [0.5, 0.7],
          builder: (BuildContext context, ScrollController scrollController) {
            return ChangeNotifierProvider.value(
              value: scrollController,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xffF1F1F1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: UsuarioPanel(),
              ),
            );
          },
        ),
      ],
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const UsuarioPanelBottomSheet(),
    );
  }
}

class UsuarioPanel extends StatefulWidget {
  const UsuarioPanel({super.key});

  @override
  State<UsuarioPanel> createState() => _UsuarioPanelState();
}

class _UsuarioPanelState extends State<UsuarioPanel> {
  final controller = Get.put(RegistroDeUsuarioController(id: ''));

  late final ScrollController scroll = context.read();

  @override
  void initState() {
    controller.cargarUsuario();

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
      if (scroll.IsBottom) {
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
                  if (controller.registro.value == RegistroSeleccionado.hilo)
                    const RegistrosHilos(),
                  if (controller.registro.value ==
                      RegistroSeleccionado.comentario)
                    const RegistrosComentarios(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class UsuarioPanelSkeleton extends StatelessWidget {
  const UsuarioPanelSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        const UsuarioRegistroSkeleton(),
        SliverList.builder(
          itemCount: 10,
          itemBuilder: (context, index) => const RegistroItemSkeleton(),
        ),
      ],
    );
  }
}
