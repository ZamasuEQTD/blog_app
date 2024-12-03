import 'package:blog_app/features/auth/domain/itoken_decode.dart';
import 'package:blog_app/features/auth/domain/models/usuario.dart';

class LocalTokenDecode extends ITokenDecode {
  @override
  Future<Usuario> decode(String token) async {
    return const Usuario(
      usuario: "Anonimo",
      rango: Anonimo(),
    );
  }
}
