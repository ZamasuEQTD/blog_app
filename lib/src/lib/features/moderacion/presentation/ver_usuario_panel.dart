import 'package:blog_app/src/lib/features/app/presentation/extensions/scroll_controller_extensions.dart';
import 'package:blog_app/src/lib/features/notificaciones/presentation/screens/notificaciones_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../domain/models/usuario.dart';
import 'logic/controllers/ver_usuario_controller.dart';

class VerUsuarioPanel extends StatefulWidget {
  final String usuario;
  const VerUsuarioPanel({super.key, required this.usuario});

  @override
  State<VerUsuarioPanel> createState() => _VerUsuarioPanelState();
}

class _VerUsuarioPanelState extends State<VerUsuarioPanel> {
  late final controller = Get.put(
    VerUsuarioController(
      id: widget.usuario,
    ),
  );
  ScrollController scroll = ScrollController();

  @override
  void initState() {
    controller.usuario.listen(
      (usuario) {
        if (usuario != null) {
          scroll.addListener(
            () {
              if (scroll.IsBottom) {
                controller.cargarHistorial();
              }
            },
          );
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: scroll,
          slivers: [
            Obx(
              () {
                if (controller.cargando.value) {
                  return SliverMainAxisGroup(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: Center(
                          child: Row(
                            children: [
                              Bone.circle(
                                size: 70,
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Bone.text(
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Bone.text(
                                    words: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverList.builder(
                        itemBuilder: (context, index) =>
                            const SocialInteraction.bone(),
                      ),
                    ],
                  );
                }

                return SliverMainAxisGroup(
                  slivers: [
                    _InformacionDeUsuario(
                      usuario: Usuario(
                        id: "id",
                        nombre: "nombre",
                        registrado: DateTime.now(),
                      ),
                    ).sliverBox,
                    SliverToBoxAdapter(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.error,
                          ),
                        ),
                        child: const Text("Banear usuario"),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ClipRRect(
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
                                SeleccionarHistorialButton.hilos(),
                                SeleccionarHistorialButton.comentarios(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () {
                        if (controller.historial.value ==
                            TipoDeHistorial.hilos) {
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _InformacionDeUsuario extends StatelessWidget {
  final Usuario usuario;

  const _InformacionDeUsuario({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ClipOval(
            child: ColoredBox(
              color: Color(0xfff5f5f5),
              child: SizedBox.square(
                dimension: 70,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.user,
                    size: 35,
                  ),
                ),
              ),
            ),
          ),
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
      ),
    );
  }
}

abstract class SeleccionarHistorialButton extends StatelessWidget {
  const SeleccionarHistorialButton._({super.key});

  const factory SeleccionarHistorialButton({
    required void Function() onTap,
    required bool seleccionado,
    required Widget child,
  }) = _SeleccionarHistorialButton;

  const factory SeleccionarHistorialButton.comentarios() =
      _SeleccionarHistorialDeComentarios;

  const factory SeleccionarHistorialButton.hilos() =
      _SeleccionarHistorialDeHilos;
}

class _SeleccionarHistorialButton extends SeleccionarHistorialButton {
  final void Function() onTap;
  final bool seleccionado;
  final Widget child;
  const _SeleccionarHistorialButton({
    required this.onTap,
    required this.seleccionado,
    required this.child,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    Widget child = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: this.child,
    );

    if (seleccionado) {
      child = ColoredBox(color: Theme.of(context).scaffoldBackgroundColor);
    }

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: child,
        ),
      ),
    );
  }
}

class _SeleccionarHistorialDeHilos extends SeleccionarHistorialButton {
  const _SeleccionarHistorialDeHilos() : super._();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VerUsuarioController>();
    return Obx(
      () => SeleccionarHistorialButton(
        onTap: () => controller.historial.value = TipoDeHistorial.hilos,
        seleccionado: controller.historial.value == TipoDeHistorial.hilos,
        child: const Row(
          children: [
            FaIcon(
              FontAwesomeIcons.noteSticky,
              size: 20,
              color: Colors.black,
            ),
            SizedBox(width: 8),
            Text(
              "Hilos",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _SeleccionarHistorialDeComentarios extends SeleccionarHistorialButton {
  const _SeleccionarHistorialDeComentarios() : super._();
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VerUsuarioController>();

    return SeleccionarHistorialButton(
      onTap: () => controller.historial.value = TipoDeHistorial.comentarios,
      seleccionado: controller.historial.value == TipoDeHistorial.comentarios,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.message,
            size: 20,
            color: Colors.black,
          ),
          SizedBox(width: 8),
          Text(
            "Comentarios",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
