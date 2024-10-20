import 'package:blog_app/features/auth/presentation/widgets/bottom_sheet/sesion_requerida_bottomsheet.dart';
import 'package:blog_app/features/notificaciones/domain/models/notificacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificacionCard extends StatelessWidget {
  const NotificacionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: ColoredBox(
          color: const Color(0xfff5f5f5),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: const SizedBox(
                            height: 80,
                            width: 80,
                            child: Image(
                              image: NetworkImage(
                                "https://comiquetaxxx.com/wp-content/uploads/2023/10/seme-pan-rom-0-350x487.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                maxLines: 2,
                                text: const TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  text: "Han comentado el hilo: ",
                                  children: [
                                    TextSpan(
                                      text:
                                          "El secreto de las montañasdsadasdasdasdasdasdasdasdsadada",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Flexible(
                                child: Text(
                                  "Sos un pelotudoooooooooooooooooooooooooooooooooooooooooooSos un pelotudoooooooooooooooooooooooooooooooooooooooooooSos un pelotudoooooooooooooooooooooooooooooooooooooooooooSos un pelotudoooooooooooooooooooooooooooooooooooooooooooSos un pelotudoooooooooooooooooooooooooooooooooooooooooooSos un pelotudoooooooooooooooooooooooooooooooooooooooooooSos un pelotudoooooooooooooooooooooooooooooooooooooooooooSos un pelotudoooooooooooooooooooooooooooooooooooooooooooSos un pelotudooooooooooooooooooooooooooooooooooooooooooo",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(),
                            child: TextButton(
                              style: FlatBtnStyle().copyWith(
                                elevation: const WidgetStatePropertyAll(1),
                                backgroundColor: const WidgetStatePropertyAll(
                                  Colors.white,
                                ),
                              ),
                              onPressed: () {},
                              child: const Text("Marcar como leida"),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text("Ver post"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

abstract class Notificacion extends StatelessWidget {
  const Notificacion._({super.key});

  const factory Notificacion.bone() = _NotificacionBone;
}

class _Notificacion extends Notificacion {
  const _Notificacion() : super._();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _NotificacionBone extends Notificacion {
  const _NotificacionBone() : super._();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                child: Bone.circle(size: 80),
              ),
              SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Bone.text(
                    fontSize: 20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Bone.multiText(
                    fontSize: 15,
                    lines: 2,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
