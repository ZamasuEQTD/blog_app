import 'package:blog_app/features/baneos/domain/ibaneos_repository.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

enum Razon {
  spam,
  contenidoInapropiado,
  otros,
}

enum Duracion {
  minutos,
  unaHora,
  unDia,
  unaSemana,
  unMes,
  indefinido,
}

enum BanearStatus {
  initial,
  loading,
  success,
  error,
}

class BanearUsuarioController extends GetxController {
  var status = Rx<BanearStatus>(BanearStatus.initial);
  var razon = Rx<Razon?>(null);
  var duracion = Rx<Duracion?>(null);
  var mensaje = Rx<String>("");

  final String id;

  BanearUsuarioController({required this.id});
  Future banear() async {
    if (status.value == BanearStatus.loading) return;

    status.value = BanearStatus.loading;

    var repository = GetIt.I.get<IBaneosRepository>();

    var res = await repository.banear(
      id: id,
      razon: razon.value!,
      duracion: duracion.value!,
      mensaje: mensaje.value,
    );

    res.fold(
      (l) => status.value = BanearStatus.error,
      (r) => status.value = BanearStatus.success,
    );

    status.value = BanearStatus.initial;
  }
}
