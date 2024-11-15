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

    Get.delete<EncuestaController>();
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
      () => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ColoredBox(
          color: Colors.white,
          child: Column(
            children: [
              ...controller.encuesta.value.respuestas.map(
                (r) => Obx(
                  () => MultiProvider(
                    providers: [
                      Provider.value(value: r),
                      Provider.value(value: controller.encuesta.value),
                    ],
                    child: const RespuestaView(),
                  ),
                ).marginOnly(bottom: 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Votos: ${controller.encuesta.value.votos}"),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      textStyle: const WidgetStatePropertyAll(
                        TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onPressed: () => controller.votar(),
                    child: const Text("Votar"),
                  ),
                ],
              ),
            ],
          ).paddingAll(16),
        ),
      ),
    );
  }
}

class RespuestaView extends StatelessWidget {
  static final radius = BorderRadius.circular(8);
  const RespuestaView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Respuesta respuesta = context.watch<Respuesta>();

    return GestureDetector(
      onTap: () => Get.find<EncuestaController>().seleccionar(respuesta.id),
      behavior: HitTestBehavior.opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(
            color: Colors.blueAccent,
            strokeAlign: 0.5,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: radius,
                        child: ColoredBox(
                          color: const Color.fromRGBO(229, 231, 235, 1),
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            child: ClipRect(
                              child: SizedBox(
                                height: constraints.maxHeight,
                                width: constraints.maxWidth *
                                    (respuesta.porcentaje(
                                          context.watch<Encuesta>().votos,
                                        ) /
                                        100),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    respuesta.respuesta,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(55, 65, 81, 1),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${respuesta.votos} Votos",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(17, 24, 39, 1),
                      ),
                    ),
                    Obx(() {
                      if (Get.find<EncuestaController>().seleccionada.value ==
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
                              dimension: 16,
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
            ).paddingSymmetric(horizontal: 10, vertical: 16),
          ],
        ),
      ),
    );
  }
}
