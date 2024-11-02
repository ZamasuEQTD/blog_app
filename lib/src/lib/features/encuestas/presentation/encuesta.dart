// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/src/lib/features/encuestas/presentation/encuesta_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../domain/hub/iencuesta_hub.dart';
import '../domain/models/encuesta.dart';

class EncuestaView extends StatefulWidget {
  final Encuesta encuesta;

  const EncuestaView({super.key, required this.encuesta});

  @override
  State<EncuestaView> createState() => _EncuestaViewState();
}

class _EncuestaViewState extends State<EncuestaView> {
  late final IEncuestaHub hub;
  late final controller = Get.put(
    EncuestaController(encuesta: widget.encuesta),
  );

  @override
  void dispose() {
    hub.disconnect();
    super.dispose();
  }

  @override
  void initState() {
    hub = LocalEncuestaHub(
      respuestas: widget.encuesta.respuestas.map((e) => e.id).toList(),
    );

    hub.connect();

    hub.onVotoSumado.listen((respuesta) {
      controller.sumarVoto(respuesta);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...controller.encuesta.value.respuestas.map(
            (r) => Obx(
              () => MultiProvider(
                providers: [
                  Provider.value(value: controller.encuesta.value),
                  Provider.value(
                    value: r,
                  ),
                ],
                child: const RespuestaView(),
              ),
            ).marginOnly(bottom: 10),
          ),
          Row(
            children: [
              Obx(
                () => Text("Votos ${controller.encuesta.value.votos}"),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.votar(),
              child: const Text("Votar"),
            ),
          ),
        ],
      ),
    );
  }
}

class RespuestaView extends StatelessWidget {
  const RespuestaView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Respuesta respuesta = context.watch<Respuesta>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () => Get.find<EncuestaController>().seleccionar(respuesta.id),
        child: ColoredBox(
          color: Colors.white,
          child: Stack(
            children: [
              Positioned.fill(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ColoredBox(
                          color: Colors.grey.withOpacity(0.2),
                          child: SizedBox(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth *
                                (respuesta.porcentaje(
                                      context.read<Encuesta>().votos,
                                    ) /
                                    100),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        respuesta.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${respuesta.porcentaje(
                                context.read<Encuesta>().votos,
                              ).toInt()}%",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Obx(() {
                          if (Get.find<EncuestaController>()
                                      .seleccionada
                                      .value ==
                                  respuesta.id ||
                              Get.find<EncuestaController>()
                                      .encuesta
                                      .value
                                      .respuesta ==
                                  respuesta.id) {
                            return ClipOval(
                              child: ColoredBox(
                                color: Colors.green.withOpacity(0.7),
                                child: SizedBox.square(
                                  dimension: 18,
                                  child: FittedBox(
                                    child: const FaIcon(
                                      FontAwesomeIcons.check,
                                      color: Colors.white,
                                    ).paddingAll(5),
                                  ),
                                ),
                              ),
                            )
                                .animate()
                                .scale(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.bounceOut,
                                )
                                .marginOnly(left: 5);
                          }
                          return const SizedBox();
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
