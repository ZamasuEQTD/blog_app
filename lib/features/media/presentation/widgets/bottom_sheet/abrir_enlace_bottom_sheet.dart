import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/presentation/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import '../../../../app/presentation/widgets/dialog/widgets/titulo.dart';

import 'package:url_launcher/url_launcher.dart';

class AbrirEnlaceExternoBottomSheet extends StatelessWidget {
  final String url;
  const AbrirEnlaceExternoBottomSheet({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet.normal(
      titulo: const DialogTitulo.text(titulo: "Advertencia"),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Text(
              "Estás a punto de salir de la aplicación para visitar un sitio externo.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(108, 117, 125, 1),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ColoredBox(
                color: Colors.white,
                // color: const Color(0xffE9ECEF),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      url,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: Color.fromRGBO(73, 80, 87, 1)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "No podemos garantizar la seguridad o el contenido de sitios externos. ¿Deseas continuar?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(108, 117, 125, 1),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (!await launchUrl(Uri.parse(url))) {
                    throw Exception('Could not launch $url');
                  }

                  if (context.mounted) context.pop();
                },
                child: const Text("Continuar"),
              ),
            ),
          ],
        ).paddingOnly(
          bottom: 10,
        ),
      ),
    );
  }
}
