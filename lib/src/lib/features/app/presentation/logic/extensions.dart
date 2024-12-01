import 'package:blog_app/src/lib/features/app/presentation/widgets/seleccionable/grupo_seleccionable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension GruposSeleccionablesSlivers on List<GrupoItemSeleccionable> {
  List<Widget> get addSliverPadding {
    List<Widget> slivers = [];

    for (var i = 0; i < length; i++) {
      Widget child = this[i];

      if (i != length - 1) {
        child = SliverPadding(
          padding: const EdgeInsets.only(bottom: 5),
          sliver: child,
        );
      }

      slivers.add(child);
    }

    return slivers;
  }
}

extension GruposSeleccionables on List<GrupoItemSeleccionable> {
  List<Widget> get addPadding {
    List<Widget> slivers = [];

    for (var i = 0; i < length; i++) {
      Widget child = this[i];

      if (i != length - 1) {
        child = child.paddingOnly(bottom: 10);
      }

      slivers.add(child);
    }

    return slivers;
  }
}
