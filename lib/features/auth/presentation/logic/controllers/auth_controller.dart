import 'dart:async';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../../features/auth/domain/models/usuario.dart';
import '../../../../../../../features/auth/domain/itoken_decode.dart';
import '../../../../../../../features/auth/domain/itoken_storage.dart';

enum AuthState { initial, authenticating, authenticated, unauthenticated }

class AuthController extends GetxController {
  final ITokenDecode _tokenDecoder = GetIt.I.get();
  final ITokenStorage _tokenStorage = GetIt.I.get();

  var iniciando = false.obs;

  final usuario = Rx<Usuario?>(null);

  final token = Rx<String?>(null);

  final authState = Rx<AuthState>(AuthState.initial);

  bool get isAuthenticated => authState.value == AuthState.authenticated;

  Future<void> login(String token) async {
    iniciando.value = true;

    await _tokenStorage.guardar(token);

    this.token.value = token;

    Usuario decodedUsuario = await _tokenDecoder.decode(token);

    usuario.value = decodedUsuario;

    authState.value = AuthState.authenticated;

    iniciando.value = false;
  }

  Future<void> logout() async {
    await _tokenStorage.eliminar();

    token.value = null;
    usuario.value = null;

    authState.value = AuthState.unauthenticated;
  }

  Future<void> restaurarSesion() async {
    authState.value = AuthState.authenticating;
    final storedToken = await _tokenStorage.recuperar();
    if (storedToken != null) {
      await login(storedToken);
    }
  }

  bool get sesionIniciada => authState.value == AuthState.authenticated;
}
