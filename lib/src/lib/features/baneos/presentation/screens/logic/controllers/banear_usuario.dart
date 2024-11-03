import 'package:get/get.dart';

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
  void banear() {}
}
