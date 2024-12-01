import 'package:blog_app/src/lib/features/app/presentation/widgets/snackbar.dart';
import 'package:blog_app/src/lib/features/hilo/domain/ihilos_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class GestorDeHilo {
  const GestorDeHilo._();

  static Future favoritos(BuildContext context, String id) async {
    var res = await GetIt.I.get<IHilosRepository>().ponerEnFavoritos(id: id);

    res.fold(
      (l) => Snackbars.showFailure(context, l),
      (r) => Snackbars.showSuccess(
        context,
        "Hilo agregado a favoritos",
      ),
    );
  }

  static Future seguir(BuildContext context, String id) async {
    var res = await GetIt.I.get<IHilosRepository>().seguir(id: id);

    res.fold(
      (l) => Snackbars.showFailure(context, l),
      (r) => Snackbars.showSuccess(
        context,
        "Hilo agregado a seguidos",
      ),
    );
  }

  static Future ocultar(BuildContext context, String id) async {
    var res = await GetIt.I.get<IHilosRepository>().ocultar(id: id);

    res.fold(
      (l) => Snackbars.showFailure(context, l),
      (r) => Snackbars.showSuccess(
        context,
        "Hilo ocultado",
      ),
    );
  }

  static Future establecerSticky(BuildContext context, String id) async {
    var res = await GetIt.I.get<IHilosRepository>().establecerSticky(id: id);

    res.fold(
      (l) => Snackbars.showFailure(context, l),
      (r) => Snackbars.showSuccess(
        context,
        "Sticky establecido!!!",
      ),
    );
  }
}
