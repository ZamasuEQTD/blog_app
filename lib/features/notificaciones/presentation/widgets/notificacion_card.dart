import 'package:blog_app/features/auth/presentation/widgets/bottom_sheet/sesion_requerida_bottomsheet.dart';
import 'package:flutter/material.dart';

class NotificacionCard extends StatelessWidget {
  const NotificacionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.transparent,
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
                      child: const ColoredBox(
                        color: Colors.red,
                        child: SizedBox(
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
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Flexible(
                      child: Column(
                        children: [
                          Text(
                            "Han comentado tu post: El secreto de las montañas",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                            ),
                            maxLines: 2,
                          ),
                          Flexible(
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
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(),
                        child: TextButton(
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
    );
  }
}
