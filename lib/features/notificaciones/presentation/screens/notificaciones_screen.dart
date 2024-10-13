import 'package:blog_app/features/notificaciones/presentation/widgets/notificacion_card.dart';
import 'package:flutter/material.dart';

class NotificacionesScreen extends StatelessWidget {
  const NotificacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis notificaciones"),
        actions: [
          TextButton(onPressed: () {}, child: const Text("Leer todas"))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList.builder(
            itemBuilder: (context, index) => const NotificacionCard(),
          )
        ],
      ),
    );
  }
}
