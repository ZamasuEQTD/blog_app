// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/features/app/presentation/logic/extensions/duration_extension.dart';
import 'package:blog_app/features/app/presentation/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/features/app/presentation/widgets/dialog/widgets/titulo.dart';
import 'package:flutter/material.dart';

import 'package:blog_app/features/baneos/domain/models/baneo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HasSidoBaneadoBottomsheet extends StatelessWidget {
  final Baneo baneo;
  const HasSidoBaneadoBottomsheet({
    super.key,
    required this.baneo,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet.normal(
      titulo: const DialogTitulo(
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              size: 50,
              color: Color.fromRGBO(73, 80, 87, 1),
            ),
            Text(
              "Has sido baneado",
              style: DialogTituloTextStyle(
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
                  baneo.finaliza == null
                      ? "Permanente"
                      : "Finaliza en :${baneo.finaliza!.tiempoTranscurrido}",
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
                    color: Colors.white,
                    // color: const Color.fromRGBO(233, 236, 239, 1),
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
              child: ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text("Aceptar"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void show(
    BuildContext context, {
    required Baneo baneo,
  }) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) {
        return HasSidoBaneadoBottomsheet(
          baneo: baneo,
        );
      },
    );
  }
}
