import 'package:blog_app/src/lib/features/hilo/domain/ihilos_repository.dart';
import 'package:blog_app/src/lib/features/hilo/domain/models/types.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class PostearHiloController extends GetxController {
  final IHilosRepository repository = GetIt.I.get();

  Rx<String> titulo = Rx("");
  Rx<String> descripcion = Rx("");
  Rx<List<String>> encuesta = Rx([]);

  Rx<bool> idunico = Rx(false);
  Rx<bool> dados = Rx(false);

  Rx<HiloId?> id = Rx(null);

  RxBool posteando = false.obs;

  void postear() async {
    posteando.value = true;

    var result = await repository.postear(
      titulo: titulo.value,
      descripcion: descripcion.value,
    );

    result.fold(
      (l) => null,
      (r) => id.value = r,
    );

    posteando.value = false;
  }
}
