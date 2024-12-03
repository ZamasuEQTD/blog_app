import 'dart:collection';

import 'package:blog_app/features/baneos/presentation/screens/widgets/bottom_sheet/seleccionar_duracion.dart';
import 'package:blog_app/features/baneos/presentation/screens/widgets/bottom_sheet/seleccionar_razon.dart';
import 'package:blog_app/features/moderacion/presentation/ver_usuario_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'logic/controllers/banear_usuario.dart';

final HashMap<Duracion, String> duraciones = HashMap.from({
  Duracion.minutos: " 5 Minutos",
  Duracion.unaHora: "1 Hora",
  Duracion.unDia: "1 Día",
  Duracion.unaSemana: "1 Semana",
  Duracion.unMes: "1 Mes",
  Duracion.indefinido: "Permanente",
});

final HashMap<Razon, String> razones = HashMap.from({
  Razon.spam: "Spam",
  Razon.contenidoInapropiado: "Contenido inapropiado",
  Razon.otros: "Otros",
});

class BanearUsuarioScreen extends StatefulWidget {
  final String id;

  const BanearUsuarioScreen({super.key, required this.id});

  @override
  State<BanearUsuarioScreen> createState() => _BanearUsuarioScreenState();
}

class _BanearUsuarioScreenState extends State<BanearUsuarioScreen> {
  late final controller = Get.put(BanearUsuarioController(id: widget.id));

  @override
  void initState() {
    controller.status.listen((status) {
      if (status == BanearStatus.success) {
        context.pop();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: controller.status.value != BanearStatus.loading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Banear usuario"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mensaje",
              style: context.labelStyle,
            ),
            const TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Mensaje",
              ),
            ).withMarginSection,
            Text("Razon", style: context.labelStyle),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => SeleccionarRazon(
                    onRazonSeleccionada: (razon) =>
                        controller.razon.value = razon,
                  ),
                ),
                child: ColoredBox(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                            controller.razon.value != null
                                ? razones[controller.razon.value!]!
                                : "Seleccionar razon",
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              ),
            ).withMarginSection,
            Text("Duracion", style: context.labelStyle),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => SeleccionarDuracion(
                    onDuracionSeleccionada: (duracion) =>
                        controller.duracion.value = duracion,
                  ),
                ),
                child: ColoredBox(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                            controller.duracion.value != null
                                ? duraciones[controller.duracion.value!]!
                                : "Seleccionar duración",
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              ),
            ).withMarginSection,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                  ),
                ),
                onPressed: () => controller.banear(),
                child: const Text("Banear usuario"),
              ),
            ).paddingSymmetric(horizontal: 25),
          ],
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}

extension MarginExtension on Widget {
  Widget get withMarginSection => marginOnly(bottom: 24, top: 8);
}
