import 'package:flutter/material.dart';

class ComentariosCargando extends StatelessWidget {
  const ComentariosCargando({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(itemBuilder: (context, index) => ComentarioCargando());
  }
}

class ComentarioCargando extends StatelessWidget {
  const ComentarioCargando({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}