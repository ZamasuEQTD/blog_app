import 'models/usuario.dart';

abstract class ITokenDecode {
  Future<Usuario> decode(String token);
}