import 'package:jwt_decoder/jwt_decoder.dart';

import '../domain/models/usuario.dart';
import '../domain/itoken_decode.dart';

class TokenDecode extends ITokenDecode {
  @override
  Future<Usuario> decode(String token) {
    Map<String, dynamic> json = JwtDecoder.decode(token);

    return Future.value(Usuario.formJson(json));
  }
}
