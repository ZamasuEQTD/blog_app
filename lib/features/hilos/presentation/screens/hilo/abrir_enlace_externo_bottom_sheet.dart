import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../auth/presentation/widgets/bottom_sheet/bottom_sheet.dart';
import '../../../../auth/presentation/widgets/bottom_sheet/sesion_requerida_bottomsheet.dart';

class AbrirEnlaceExternoBottomSheet extends StatelessWidget {
  final String url;
  const AbrirEnlaceExternoBottomSheet({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Estás a punto de ser redirigido a $url. ¿Estás seguro de que deseas continuar?",
            style: TextStyle(
              fontSize: 15,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _launchUrl(Uri.parse(url)),
              style:
                  FlatBtnStyle(boderRadius: BorderRadius.circular(3)).copyWith(
                backgroundColor: const WidgetStatePropertyAll(Colors.black),
              ),
              child: const Text(
                "Continuar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style:
                  FlatBtnStyle(boderRadius: BorderRadius.circular(3)).copyWith(
                backgroundColor: const WidgetStatePropertyAll(Colors.white),
              ),
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  static void show(
    BuildContext context, {
    required String url,
  }) {
    RoundedBottomSheet.show(
      context,
      options: const ShowBottomSheetOptions(),
      child: AbrirEnlaceExternoBottomSheet(
        url: url,
      ),
    );
  }
}
