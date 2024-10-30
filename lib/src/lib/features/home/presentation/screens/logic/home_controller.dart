import 'package:blog_app/src/lib/features/categorias/domain/models/subcategoria.dart';
import 'package:blog_app/src/lib/features/hilo/domain/ihilos_repository.dart';
import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class HomeController extends GetxController {
  Rx<SubcategoriaEntity?> subcategoria = Rx(null);
  Rx<DateTime?> ultimoBump = Rx(null);
  Rx<String> titulo = Rx("");
  Rx<bool> cargando = Rx(false);

  Rx<Failure?> failure = Rx(null);
  Rx<List<HomePortada>> portadas = Rx([]);

  void cargarPortadas() async {
    if (cargando.value) return;
    IHilosRepository repository = GetIt.I.get();

    var response = await repository.getPortadas(ultimoBump: ultimoBump.value);

    response.fold(
      (l) => failure.value = l,
      (r) {
        ultimoBump.value = r.lastOrNull?.ultimoBump;

        portadas.value = [...portadas.value, ...r];
      },
    );
  }

  void filtrar() {
    portadas.value = [];

    cargarPortadas();
  }

  void eliminar(HomePortadaId id) => portadas.value = portadas.value
      .where(
        (element) => element.id != id,
      )
      .toList();

  void agregarPortada(HomePortada portada) {
    if (hayFiltrosCambiados) return;

    portadas.value = [portada, ...portadas.value];
  }

  void cambiarCategoria(SubcategoriaEntity subcategoria) =>
      this.subcategoria.value = subcategoria;

  bool get hayFiltrosCambiados =>
      subcategoria.value != null || titulo.value != "";
}
