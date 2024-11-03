import 'dart:collection';

import 'package:blog_app/src/lib/features/app/presentation/widgets/dialogs/bottom_sheet.dart';
import 'package:blog_app/src/lib/features/auth/presentation/screens/registro_screen.dart';
import 'package:blog_app/src/lib/features/postear_hilo/presentation/postear_hilo_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'logic/controllers/banear_usuario.dart';

class BanearUsuarioScreen extends StatefulWidget {
  const BanearUsuarioScreen({super.key});

  @override
  State<BanearUsuarioScreen> createState() => _BanearUsuarioScreenState();
}

class _BanearUsuarioScreenState extends State<BanearUsuarioScreen> {
  static final HashMap<Duracion, String> _duraciones = HashMap.from({
    Duracion.minutos: " 5 Minutos",
    Duracion.unaHora: "1 Hora",
    Duracion.unDia: "1 Día",
    Duracion.unaSemana: "1 Semana",
    Duracion.unMes: "1 Mes",
    Duracion.indefinido: "Permanente",
  });

  static final HashMap<Razon, String> _razones = HashMap.from({
    Razon.spam: "Spam",
    Razon.contenidoInapropiado: "Contenido inapropiado",
    Razon.otros: "Otros",
  });

  final controller = Get.put(BanearUsuarioController());
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
      child: Theme(
        data: context.newTheme,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Banear usuario"),
          ),
          body: Column(
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
              const Text("Razon"),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
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
                        children: [
                          Obx(
                            () => Text(
                              controller.razon.value != null
                                  ? _razones[controller.razon.value!]!
                                  : "Seleccionar razon",
                            ),
                          ),
                          const Icon(Icons.chevron_left),
                        ],
                      ),
                    ),
                  ).withMarginSection,
                ),
              ),
              Text("Duracion", style: context.labelStyle),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
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
                                  ? _duraciones[controller.duracion.value!]!
                                  : "Seleccionar duración",
                            ),
                          ),
                          const Icon(Icons.chevron_left),
                        ],
                      ),
                    ),
                  ).withMarginSection,
                ),
              ),
              ElevatedButton(
                onPressed: () => controller.banear(),
                child: const Text("Banear usuario"),
              ),
            ],
          ).paddingSymmetric(horizontal: 24),
        ),
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
                onTap: () => onRazonSeleccionada(e),
                child: Text(e.name),
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
                onTap: () => onDuracionSeleccionada(e),
                child: Text(e.name),
              ),
            )
            .toList(),
      ),
    );
  }
}
