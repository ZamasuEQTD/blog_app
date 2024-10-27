// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/src/lib/features/app/domain/services/horario_service.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'package:blog_app/src/lib/features/baneos/domain/models/baneo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HasSidoBaneadoBottomsheet extends StatelessWidget {
  final Baneo baneo;
  const HasSidoBaneadoBottomsheet({
    super.key,
    required this.baneo,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet.normal(
      titulo: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              size: 50,
              color: Color.fromRGBO(73, 80, 87, 1),
            ),
            Text(
              "Has sido baneado",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(73, 80, 87, 1),
              ),
            ),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.person_outline,
                  color: Color.fromRGBO(108, 117, 125, 1),
                ),
                const SizedBox(
                  width: 10,
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Color.fromRGBO(108, 117, 125, 1),
                      fontSize: 16,
                    ),
                    children: [
                      const TextSpan(
                        text: "Moderador: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: baneo.moderador),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.clock,
                  color: Color.fromRGBO(108, 117, 125, 1),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Finaliza en :${HorarioService.diferencia(utcNow: DateTime.now().toUtc(), time: baneo.finaliza)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(108, 117, 125, 1),
                  ),
                ),
              ],
            ),
            if (baneo.mensaje != null)
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ColoredBox(
                    color: const Color.fromRGBO(233, 236, 239, 1),
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          baneo.mensaje!,
                          style: const TextStyle(
                            color: Color.fromRGBO(73, 80, 87, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xff495057)),
                ),
                child: const Text(
                  "Aceptar",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
