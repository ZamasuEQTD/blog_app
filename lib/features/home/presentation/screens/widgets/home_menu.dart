import 'package:blog_app/features/app/presentation/theme/styles/button_styles.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/grupo_seleccionable.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/item_seleccionable.dart';
import 'package:blog_app/features/auth/presentation/logic/controllers/auth_controller.dart';
import 'package:blog_app/modules/routing.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Obx(() {
          if (Get.find<AuthController>().usuario.value == null) {
            return onSinSesion(context);
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bienvenido, ${Get.find<AuthController>().usuario.value!.usuario}",
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ).marginOnly(left: 20),
              ...[
                GrupoItemSeleccionable(
                  seleccionables: [
                    ItemSeleccionable.text(
                      titulo: "Buscar hilo",
                      onTap: () => context.push("/portadas/titulo"),
                      trailing: const FaIcon(FontAwesomeIcons.magnifyingGlass),
                    ),
                    const ItemSeleccionable.text(
                      titulo: "Categorias",
                      trailing: FaIcon(FontAwesomeIcons.boxArchive),
                    ),
                  ],
                ),
                GrupoItemSeleccionable(
                  seleccionables: [
                    const ItemSeleccionable.text(titulo: "Mis hilos"),
                    ItemSeleccionable.text(
                      titulo: "Favoritos",
                      onTap: () => context.push("/colecciones/favoritos"),
                    ),
                    ItemSeleccionable.text(
                      titulo: "Ocultos",
                      onTap: () => context.push("/colecciones/ocultos"),
                    ),
                    ItemSeleccionable.text(
                      titulo: "Seguidos",
                      onTap: () => context.push("/colecciones/ocultos"),
                    ),
                  ],
                ),
                const GrupoItemSeleccionable(
                  seleccionables: [
                    ItemSeleccionable.text(
                      titulo: "Configuración",
                      trailing: FaIcon(FontAwesomeIcons.gear),
                    ),
                  ],
                ),
                GrupoItemSeleccionable(
                  seleccionables: [
                    ItemSeleccionable.text(
                      titulo: "Cerrar sesión",
                      trailing: const FaIcon(FontAwesomeIcons.rightFromBracket),
                      onTap: () => Get.find<AuthController>().logout(),
                    ),
                  ],
                ),
              ],
            ],
          );
        }),
      ),
    );
  }

  Widget onSinSesion(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.push(Routes.login);
              },
              child: const Text("Iniciar Sesión"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.push(Routes.registro);
              },
              child: const Text("Registrarse"),
            ).withSecondaryStyle(context),
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: 20);
  }
}
