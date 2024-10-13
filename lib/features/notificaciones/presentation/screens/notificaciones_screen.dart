import 'package:blog_app/features/notificaciones/presentation/widgets/notificacion_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificacionesScreen extends StatelessWidget {
  const NotificacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () => context.pop(),
        ),
        title: const Text(
          "Mis notificaciones",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        actions: [
          TextButton(onPressed: () {}, child: const Text("Leer todas")),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList.builder(
            itemCount: 10,
            itemBuilder: (context, index) => const NotificacionCard(),
          ),
        ],
      ),
    );
  }
}
