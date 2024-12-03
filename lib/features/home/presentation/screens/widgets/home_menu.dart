import 'package:blog_app/features/app/presentation/theme/styles/button_styles.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/item_seleccionable.dart';
import 'package:blog_app/features/auth/presentation/logic/controllers/auth_controller.dart';
import 'package:blog_app/modules/routing.dart';
import 'package:flutter/material.dart';
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
          return Column(
            children: [
              Text(
                "Bienvenido, ${Get.find<AuthController>().usuario.value!.usuario}",
                style: context.textTheme.titleMedium,
              ),
              ItemSeleccionable.text(
                onTap: () => context.push(Routes.misHilos),
                titulo: "Mis hilos",
              ),
              const ItemSeleccionable.text(
                titulo: "Hilos favoritos",
              ),
              const ItemSeleccionable.text(
                titulo: "Palabras bloqueadas",
              ),
              ItemSeleccionable.text(
                titulo: "Cerrar sesion",
                onTap: () => Get.find<AuthController>().logout(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
