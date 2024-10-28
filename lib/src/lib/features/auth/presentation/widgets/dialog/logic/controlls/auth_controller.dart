import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../usuarios/domain/models/usuario.dart';
import '../../../../../domain/itoken_decode.dart';
import '../../../../../domain/itoken_storage.dart';

class AuthController extends GetxController {
  final ITokenDecode _tokenService = GetIt.I.get();
  final ITokenStorage _tokenStorage = GetIt.I.get();

  var iniciando = false.obs;

  Rx<Usuario?> usuario = Rx(null);

  Future<void> login(String token) async {
    iniciando.value = true;

    await _tokenStorage.guardar(token);

    Usuario decodedUsuario = await _tokenService.decode(token);

    usuario.value = decodedUsuario;

    iniciando.value = false;
  }

  Future<void> restaurarSesion() async {
    String? token = await _tokenStorage.recuperar();

    if (token != null) {
      usuario.value = await _tokenService.decode(token);
    }
  }
}
