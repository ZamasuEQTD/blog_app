import 'dart:collection';

import 'package:blog_app/src/lib/features/app/presentation/widgets/dialogs/bottom_sheet.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/item_seleccionable.dart';
import 'package:blog_app/src/lib/features/auth/presentation/screens/registro_screen.dart';
import 'package:blog_app/src/lib/features/postear_hilo/presentation/postear_hilo_screen.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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

typedef OnRazonSeleccionada = void Function(Razon razon);

class SeleccionarRazon extends StatelessWidget {
  final OnRazonSeleccionada onRazonSeleccionada;

  const SeleccionarRazon({super.key, required this.onRazonSeleccionada});

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet.normal(
      child: Column(
        children: Razon.values
            .map(
              (e) => GestureDetector(
                onTap: () {
                  onRazonSeleccionada(e);
                  context.pop();
                },
                child: ItemSeleccionable.text(titulo: razones[e]!),
              ),
            )
            .toList(),
      ),
    );
  }
}

typedef OnDuracionSeleccionada = void Function(Duracion duracion);

class SeleccionarDuracion extends StatelessWidget {
  final OnDuracionSeleccionada onDuracionSeleccionada;

  const SeleccionarDuracion({super.key, required this.onDuracionSeleccionada});

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet.normal(
      child: Column(
        children: Duracion.values
            .map(
              (e) => GestureDetector(
                onTap: () => {
                  onDuracionSeleccionada(e),
                  context.pop(),
                },
                child: ItemSeleccionable.text(titulo: duraciones[e]!),
              ),
            )
            .toList(),
      ),
    );
  }
}
