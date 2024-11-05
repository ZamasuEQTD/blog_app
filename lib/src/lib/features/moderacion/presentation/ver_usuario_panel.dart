import 'package:blog_app/src/lib/features/app/presentation/extensions/scroll_controller_extensions.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/dialogs/bottom_sheet.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/logic/controllers/ver_hilo_controller.dart';
import 'package:blog_app/src/lib/features/notificaciones/presentation/screens/notificaciones_screen.dart';
import 'package:blog_app/src/lib/modules/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../domain/models/usuario.dart';
import 'logic/controllers/ver_usuario_controller.dart';

class VerUsuarioPanelBottomSheet extends StatelessWidget {
  const VerUsuarioPanelBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.5,
      initialChildSize: 0.5,
      maxChildSize: 0.7,
      snap: true,
      snapSizes: const [0.5, 0.7],
      builder: (BuildContext context, ScrollController scrollController) {
        return DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              _VerUsuarioPanel(usuario: "", scroll: scrollController),
            ],
          ),
        );
      },
    );
  }
}

class _VerUsuarioPanel extends StatefulWidget {
  final ScrollController scroll;
  final String usuario;
  const _VerUsuarioPanel({
    super.key,
    required this.usuario,
    required this.scroll,
  });

  @override
  State<_VerUsuarioPanel> createState() => __VerUsuarioPanelState();
}

class __VerUsuarioPanelState extends State<_VerUsuarioPanel> {
  late final controller = Get.put(
    VerUsuarioController(
      id: widget.usuario,
    ),
  );

  late final ScrollController scroll = widget.scroll;

  @override
  void dispose() {
    Get.delete<VerUsuarioController>();
    super.dispose();
  }

  @override
  void initState() {
    controller.cargar();

    controller.historial.listen(
      (historial) {
        if (historial == Historial.comentarios &&
            controller.comentarios.value.isEmpty) {
          cargarSiguientePaginaDeHistorial();
        }
      },
    );

    controller.usuario.listen(
      (usuario) {
        cargarSiguientePaginaDeHistorial();

        if (usuario != null) {
          scroll.addListener(
            () {
              if (scroll.IsBottom) {
                cargarSiguientePaginaDeHistorial();
              }
            },
          );
        }
      },
    );
    super.initState();
  }

  void cargarSiguientePaginaDeHistorial() {
    if (controller.historial.value == Historial.comentarios) {
      controller.cargarComentarios();
    } else {
      controller.cargarHilos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                ),
              ),
        ),
      ),
      child: SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        sliver: SliverMainAxisGroup(
          slivers: [
            Obx(() {
              if (controller.usuario.value == null ||
                  controller.cargando.value) {
                return const SliverToBoxAdapter();
              }

              return Provider.value(
                value: controller.usuario.value,
                child: SliverMainAxisGroup(
                  slivers: [
                    const UsuarioInformacion.cargada(),
                    ElevatedButton(
                      onPressed: () => context.pushNamed(
                        Routes.banear,
                        pathParameters: {
                          "id": widget.usuario,
                        },
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.error,
                        ),
                      ),
                      child: const Text("Banear usuario"),
                    ).sliverBox,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: const ColoredBox(
                        color: Color(0xffF5F5F5),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          child: Row(
                            children: [
                              CambiarHistorialButton.hilos(),
                              CambiarHistorialButton.comentarios(),
                            ],
                          ),
                        ),
                      ),
                    ).marginOnly(bottom: 10).sliverBox,
                    Obx(
                      () {
                        if (controller.historial.value == Historial.hilos) {
                          return SliverList.builder(
                            itemCount: controller.hilos.value.length,
                            itemBuilder: (context, index) =>
                                SocialInteraction.historial(
                              historial: controller.hilos.value[index],
                            ),
                          );
                        }

                        return SliverList.builder(
                          itemCount: controller.comentarios.value.length,
                          itemBuilder: (context, index) =>
                              SocialInteraction.historial(
                            historial: controller.comentarios.value[index],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

abstract class UsuarioInformacion extends StatelessWidget {
  const UsuarioInformacion._({super.key});

  const factory UsuarioInformacion({required List<Widget> children}) =
      _UsuarioInformacion;

  const factory UsuarioInformacion.bone() = _UsuarioInformacionBone;
  const factory UsuarioInformacion.cargada() = _UsuarioInformacionCargada;
}

class _UsuarioInformacion extends UsuarioInformacion {
  final List<Widget> children;
  const _UsuarioInformacion({required this.children}) : super._();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    ).marginSymmetric(vertical: 15).sliverBox;
  }
}

class _UsuarioInformacionCargada extends UsuarioInformacion {
  const _UsuarioInformacionCargada() : super._();
  @override
  Widget build(BuildContext context) {
    Usuario usuario = context.read();
    return UsuarioInformacion(
      children: [
        const UsuarioFoto.icono(),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              usuario.nombre,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            Text(
              "Unido desde ${usuario.registrado.day}/${usuario.registrado.month}/${usuario.registrado.year}",
            ),
          ],
        ),
      ],
    );
  }
}

class _UsuarioInformacionBone extends UsuarioInformacion {
  const _UsuarioInformacionBone() : super._();
  @override
  Widget build(BuildContext context) {
    return const UsuarioInformacion(
      children: [
        UsuarioFoto.bone(),
        SizedBox(width: 10),
        Bone.text(
          words: 10,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        Bone.text(
          words: 10,
        ),
      ],
    );
  }
}

abstract class UsuarioFoto extends StatelessWidget {
  const UsuarioFoto._({super.key});
  const factory UsuarioFoto({required Widget child}) = _UsuarioFoto;

  const factory UsuarioFoto.icono() = _UsuarioFotoIcono;
  const factory UsuarioFoto.bone() = _UsuarioFotoBone;
}

class _UsuarioFoto extends UsuarioFoto {
  final Widget child;
  const _UsuarioFoto({required this.child}) : super._();
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox.square(
        dimension: 70,
        child: child,
      ),
    );
  }
}

class _UsuarioFotoBone extends UsuarioFoto {
  const _UsuarioFotoBone() : super._();
  @override
  Widget build(BuildContext context) {
    return const _UsuarioFoto(child: Bone());
  }
}

class _UsuarioFotoIcono extends UsuarioFoto {
  const _UsuarioFotoIcono() : super._();

  @override
  Widget build(BuildContext context) {
    return const _UsuarioFoto(
      child: Center(
        child: FaIcon(
          FontAwesomeIcons.user,
          size: 35,
        ),
      ),
    );
  }
}

abstract class CambiarHistorialButton extends StatelessWidget {
  const CambiarHistorialButton._({super.key});

  const factory CambiarHistorialButton({
    required Historial historial,
    required Widget label,
    required Widget icon,
  }) = _CambiarHistorialButton;

  const factory CambiarHistorialButton.hilos() = _CambiarHistorialDeHilos;
  const factory CambiarHistorialButton.comentarios() =
      _CambiarHistorialDeComentarios;
}

class _CambiarHistorialButton extends CambiarHistorialButton {
  final Historial historial;
  final Widget label;
  final Widget icon;
  const _CambiarHistorialButton({
    required this.historial,
    required this.label,
    required this.icon,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Expanded(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            backgroundColor:
                Get.find<VerUsuarioController>().historial.value == historial
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surface,
          ),
          onPressed: _setHistorial,
          label: label,
          icon: icon,
        ),
      ),
    );
  }

  Historial _setHistorial() =>
      Get.find<VerUsuarioController>().historial.value = historial;
}

class _CambiarHistorialDeHilos extends CambiarHistorialButton {
  const _CambiarHistorialDeHilos() : super._();

  @override
  Widget build(BuildContext context) {
    return const CambiarHistorialButton(
      historial: Historial.hilos,
      label: Text("Hilos"),
      icon: FaIcon(
        FontAwesomeIcons.noteSticky,
      ),
    );
  }
}

class _CambiarHistorialDeComentarios extends CambiarHistorialButton {
  const _CambiarHistorialDeComentarios() : super._();
  @override
  Widget build(BuildContext context) {
    return const CambiarHistorialButton(
      historial: Historial.comentarios,
      label: Text("Comentarios"),
      icon: FaIcon(FontAwesomeIcons.message),
    );
  }
}
