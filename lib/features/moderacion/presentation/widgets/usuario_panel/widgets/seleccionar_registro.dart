import 'package:blog_app/features/moderacion/presentation/widgets/usuario_panel/logic/controllers/registro_de_usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SeleccionarRegistroButtonStyle extends ButtonStyle {
  SeleccionarRegistroButtonStyle()
      : super(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        );
}

class SeleccionarRegistroActivoButtonStyle extends ButtonStyle {
  const SeleccionarRegistroActivoButtonStyle()
      : super(
          backgroundColor: const WidgetStatePropertyAll(
            Colors.white,
          ),
          iconColor: const WidgetStatePropertyAll(
            Colors.black,
          ),
          foregroundColor: const WidgetStatePropertyAll(
            Colors.black,
          ),
        );
}

class SeleccionarRegistro extends StatelessWidget {
  const SeleccionarRegistro({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: ColoredBox(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: SeleccionarRegistroButtonStyle().merge(
                    Get.find<RegistroDeUsuarioController>().registro.value ==
                            RegistroSeleccionado.hilo
                        ? const SeleccionarRegistroActivoButtonStyle()
                        : null,
                  ),
                  onPressed: () {
                    RegistroDeUsuarioController controller = Get.find();

                    controller.registro.value = RegistroSeleccionado.hilo;
                  },
                  icon: const FaIcon(FontAwesomeIcons.fileLines),
                  label: const Text("Hilos"),
                ),
              ),
              Expanded(
                child: ElevatedButton.icon(
                  style: SeleccionarRegistroButtonStyle().merge(
                    Get.find<RegistroDeUsuarioController>().registro.value ==
                            RegistroSeleccionado.comentario
                        ? const SeleccionarRegistroActivoButtonStyle()
                        : null,
                  ),
                  onPressed: () {
                    RegistroDeUsuarioController controller = Get.find();

                    controller.registro.value = RegistroSeleccionado.comentario;
                  },
                  icon: const FaIcon(FontAwesomeIcons.message),
                  label: const Text("Comentarios"),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 10, vertical: 5),
        ),
      ).sliverBox,
    );
  }
}
